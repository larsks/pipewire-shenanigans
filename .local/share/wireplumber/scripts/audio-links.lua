-- audio-links.lua
-- Maintains fixed PipeWire port-to-port links using WirePlumber's event/hook API.

-- Read arguments passed in configuration
local args = ... or {}
local config = args:parse()
local LINKS = config.links or {}

local active_links = {}
local log = Log.open_topic("audio-links")

local function link_key(out_alias, in_alias)
	return out_alias .. "->" .. in_alias
end

local function parse_alias(alias)
	return alias:match("^(.+):([^:]+)$")
end

local function find_port(source, node_name, port_name)
	local node_om = source:call("get-object-manager", "node")
	local node = node_om:lookup({
		Constraint({ "node.name", "=", node_name, type = "pw-global" }),
	})
	if not node then
		log:info("find_port: node not found: " .. node_name)
		return nil
	end
	for port in
		node:iterate_ports({
			Constraint({ "port.name", "=", port_name, type = "pw" }),
		})
	do
		log:debug(
			"find_port: found "
				.. node_name
				.. ":"
				.. port_name
				.. " object.id="
				.. (port.properties["object.id"] or "?")
		)
		return port
	end
	log:info("find_port: port not found: " .. port_name .. " on node " .. node_name)
	return nil
end

local function try_create_links(source)
	log:debug("try_create_links called")
	for _, spec in ipairs(LINKS) do
		local key = link_key(spec.output, spec.input)

		if active_links[key] then
			log:info("skipping already active link: " .. key)
		else
			local out_node, out_port = parse_alias(spec.output)
			local in_node, in_port = parse_alias(spec.input)

			local out_p = find_port(source, out_node, out_port)
			local in_p = find_port(source, in_node, in_port)

			if out_p and in_p then
				log:info("creating link: " .. key)
				local link = Link("link-factory", {
					["link.output.node"] = out_p.properties["node.id"],
					["link.output.port"] = out_p.properties["object.id"],
					["link.input.node"] = in_p.properties["node.id"],
					["link.input.port"] = in_p.properties["object.id"],
					["object.id"] = nil,
					["object.linger"] = true,
				})
				active_links[key] = "pending"
				link:activate(Feature.Proxy.BOUND, function(l, e)
					if e then
						log:warning("failed to activate link " .. key .. ": " .. tostring(e))
						active_links[key] = nil
					else
						log:info("link active: " .. key .. " bound-id=" .. tostring(l["bound-id"]))
						active_links[key] = l
					end
				end)
			else
				log:info("cannot create link yet, ports missing: " .. key)
			end
		end
	end
end

local function clear_links_for_node(name)
	log:info("clearing link records for node: " .. name)
	local cleared = false
	for _, spec in ipairs(LINKS) do
		local out_node = parse_alias(spec.output)
		local in_node = parse_alias(spec.input)
		if name == out_node or name == in_node then
			local key = link_key(spec.output, spec.input)
			log:info("clearing: " .. key .. " (was " .. tostring(active_links[key]) .. ")")
			active_links[key] = nil
			cleared = true
		end
	end
	if not cleared then
		log:info("no link records matched node: " .. name)
	end
end

SimpleEventHook({
	name = "audio-links/node-added",
	interests = {
		EventInterest({
			Constraint({ "event.type", "=", "node-added" }),
		}),
	},
	execute = function(event)
		local node = event:get_subject()
		-- On node-added, properties are available via the event properties,
		-- not just node.properties, so check both
		local name = (node.properties and node.properties["node.name"])
			or event:get_properties()["node.name"]
			or "(unnamed)"
		log:debug("node-added: " .. name)

		local relevant = false
		for _, spec in ipairs(LINKS) do
			if name == parse_alias(spec.output) or name == parse_alias(spec.input) then
				relevant = true
				break
			end
		end
		if not relevant then
			return
		end

		log:info("node-added: relevant node: " .. name)
		local source = event:get_source()
		try_create_links(source)
	end,
}):register()

SimpleEventHook({
	name = "audio-links/node-removed",
	interests = {
		EventInterest({
			Constraint({ "event.type", "=", "node-removed" }),
		}),
	},
	execute = function(event)
		-- On node-removed, node.properties may be gone; use event properties instead
		local props = event:get_properties()
		local name = props["node.name"] or "(unnamed)"
		log:info("node-removed event: node.name=" .. name)

		local relevant = false
		for _, spec in ipairs(LINKS) do
			if name == parse_alias(spec.output) or name == parse_alias(spec.input) then
				relevant = true
				break
			end
		end
		if not relevant then
			log:debug("node-removed: irrelevant node: " .. name)
			return
		end

		log:info("node-removed: relevant node: " .. name)
		clear_links_for_node(name)
	end,
}):register()

log:info("script loaded, hooks registered")
