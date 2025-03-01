-- put me on autoexecute!
-- type ".cmds" in chat for commands!

-- loadstring(game:HttpGet("http://github.com/IvanTheProtogen/ClientAdmin/raw/main/scripts/CustomImageRP.lua"))()

if game.PlaceId ~= 7007567268 then
	return
end

ClientAdmin=loadstring(game:HttpGet("http://github.com/IvanTheProtogen/ClientAdmin/raw/main/main.lua"))();

local morphFrame = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui").Gui.Frames.MorphFrame.MorphFrame

local Itb = morphFrame.id
local Xtb = morphFrame.Width
local Ytb = morphFrame.Height

local wait = task.wait
local spawn = task.spawn

local events = game:GetService("ReplicatedStorage").Events

local config = {}
config.PlaceId = 7007567268
config.Commands = {}

function config.Commands.savedimages(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	local savedimages = plr.savedimages:GetChildren()
	ExtraAbilities.Chat("Previewing "..plr.DisplayName.."'s saved images... ("..tostring(#savedimages)..")")
	for i,v in savedimages do
		events.Morph:FireServer({v.Name, 6, 6})
		wait(1.5)
	end
	ExtraAbilities.Chat("All done!")
end

function config.Commands.announce(args)
	local msg = table.concat(args," ")
	local getplrs = game:GetService("Players"):GetPlayers()
	local active = true
	spawn(function()
		wait(5)
		active = false
	end)
	while active do
		spawn(function()
			for i,v in getplrs do
				events.StartVotekick:FireServer(v, msg)
			end
		end)
		wait()
	end
end

function config.Commands.shapeshift(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	events.Morph:FireServer({string.sub(plr.Tags.CurrentImage.Value,71),10,10})
	events.RPNAME:FireServer(plr.Tags.RPNAME.Value)
end

function config.Commands.vanish()
	events.Morph:FireServer({"17429623406", 10, 10})
	events.RPNAME:FireServer("")
end

function config.Commands.copyname(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	toclipboard(plr.Tags.RPNAME.Value)
end
function config.Commands.copydecal(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	toclipboard(string.sub(plr.Tags.CurrentImage.Value, 71))
end

function config.Commands.fsp()
	events.Morph:FireServer({"90803725437474", 6, 6})
	events.RPNAME:FireServer("Freaky Skiddy Proot~ 💙")
end

function config.Commands.votekick(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	table.remove(args,1)
	events.StartVotekick:FireServer(plr,table.concat(args," "))
end 

function config.Commands.copysavedimages(args)
	local plr = ExtraAbilities.FindPlayerByName(args[1])
	local savedimages = plr.savedimages:GetChildren()
	local tbl = {}
	for i,v in savedimages do 
		tbl[i] = '"'..v.Name..'"'
	end 
	toclipboard("{"..table.concat(tbl,", ").."} -- "..plr.Name.."'s saved images")
end 

local skullanim = false
local skulldata = {
	"80083740102658",
	"93074166500144",
	"124287164668743",
	"78244561932840",
}
function config.Commands.skull() -- so cool 
	skullanim = true 
	while skullanim do 
		for i,v in skulldata do 
			events.Morph:FireServer({v,Xtb.Text,Ytb.Text})
			wait(1/(#skulldata))
		end 
	end 
end

function config.Commands.stopskull() -- so uncool 
	skullanim = false 
end 

local wobblyanim = false
function config.Commands.wobblyanim(args) -- so cool
	local speed = tonumber(args[1])
	local strength = tonumber(args[2])
	wobblyanim = true 
	local x = 0
	while wobblyanim do 
		local id = Itb.Text 
		local W = tonumber(Xtb.Text) or 6
		local H = tonumber(Ytb.Text) or 6
		W = W+(math.sin(x)*strength)
		H = H-(math.sin(x)*strength)
		events.Morph:FireServer({id,W,H})
		x=x+speed 
		wait(1/30)
	end 
end 

function config.Commands.stopwobbly() -- so uncool 
	wobblyanim = false 
end 

function config.Commands.cmds()
	local cmds = {}
	cmds[1] = {".savedimages [player]","Previews player's saved images."}
	cmds[2] = {".announce [message]","Makes an announcement. (COOLDOWN: 5 mins)"}
	cmds[3] = {".shapeshift [player]","Shapeshift as a player."}
	cmds[4] = {".vanish","Turns you invisible."}
	cmds[5] = {".copyname [player]","Copies player's RP name to your clipboard."}
	cmds[6] = {".copydecal [player]","Copies player's decal to your clipboard."}
	cmds[7] = {".fsp","Freaky Skiddy Proot~ 💙"}
	cmds[8] = {".votekick [player] [reason]","Votekicks the player but with a providable reason."}
	cmds[9] = {".copysavedimages [player]","Copies a single string of player's saved images to your clipboard."}
	cmds[10] = {".skull","Skull GIF"}
	cmds[11] = {".stopskull","No Skull GIF"}
	cmds[12] = {".wobblyanim [speed] [strength]","Makes your image wobbly"}
	cmds[13] = {".stopwobbly","Stops wobbly animation"}
	cmds[14] = {"NOTICE!","For .wobblyanim, you need to set width and height on Morph GUI."}
	cmds[15] = {"NOTICE!","This applies to .skull also."}
	cmds[16] = {"NOTICE!","Don't forget to set Image ID for .wobblyanim too!"}
	cmds[17] = {"<<END>>","The bottom of all commands"}
	for i,v in cmds do
		ExtraAbilities.Notify(table.unpack(v))
		wait(1.5)
	end
end

function config.OnStart()
	spawn(function()
		while true do 
			ExtraAbilities.Chat("IvanTheProtogen/ClientAdmin/scripts/CustomImageRP on G<I<T<H<U<B")
			wait(60)
		end 
	end)
end 

ClientAdmin(config)
