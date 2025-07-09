--!strict
local fs = require("@lune/fs")
local net = require("@lune/net")
local task = require("@lune/task")
local datetime = require("@lune/datetime")

local StudySession = require("@types/StudySession")
type StudySession = typeof(StudySession)

local DATA_FILE = "./data/study_sessions.json"

local Storage = {}

function Storage.loadSessions(): { StudySession }
	return {}
end

return Storage
