local display = false
local holdingAnim = false
local lastToggle = 0 -- debounce timer (ms)

-- Load config
local mirandaRights = Config.MirandaRights
local uiSettings = Config.UISettings

-- =========================
-- JOB CHECK
-- =========================
function HasAllowedJob()
    if not Config.JobRestriction then return true end

    -- ESX
    if GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        local data = ESX.GetPlayerData()
        if data and data.job then
            for _, job in ipairs(Config.AllowedJobs) do
                if data.job.name == job and data.job.onDuty then
                    return true
                end
            end
        end
    end

    -- QBCore
    if GetResourceState('qb-core') == 'started' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local data = QBCore.Functions.GetPlayerData()
        if data and data.job then
            for _, job in ipairs(Config.AllowedJobs) do
                if data.job.name == job and data.job.onduty then
                    return true
                end
            end
        end
    end

    return false
end

-- =========================
-- ANIMATION
-- =========================
local function PlayHoldingAnim()
    if holdingAnim then return end
    holdingAnim = true

    local ped = PlayerPedId()
    RequestAnimDict("amb@world_human_clipboard@male@base")
    while not HasAnimDictLoaded("amb@world_human_clipboard@male@base") do
        Wait(0)
    end

    TaskPlayAnim(
        ped,
        "amb@world_human_clipboard@male@base",
        "base",
        8.0,
        -8.0,
        -1,
        49,
        0,
        false,
        false,
        false
    )
end

local function StopHoldingAnim()
    if not holdingAnim then return end
    holdingAnim = false
    ClearPedTasks(PlayerPedId())
end

-- =========================
-- CONTROL LOCK + ESC CLOSE
-- =========================
CreateThread(function()
    while true do
        if display then
            -- Disable movement
            DisableControlAction(0, 30, true) -- A/D
            DisableControlAction(0, 31, true) -- W/S
            DisableControlAction(0, 21, true) -- Sprint
            DisableControlAction(0, 22, true) -- Jump

            -- Disable combat
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)

            -- Disable pause menu
            DisableControlAction(0, 199, true)
            DisableControlAction(0, 200, true)

            -- ESC closes UI
            if IsControlJustPressed(0, 200) then
                SetDisplay(false)
            end
        end
        Wait(0)
    end
end)

-- =========================
-- TOGGLE COMMAND (DEBOUNCED)
-- =========================
RegisterCommand(Config.Command, function()
    local now = GetGameTimer()
    if now - lastToggle < 300 then return end
    lastToggle = now

    if HasAllowedJob() then
        SetDisplay(not display)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            args = { "Miranda Rights", "You don't have permission to use this command." }
        })
    end
end, false)

RegisterKeyMapping(Config.Command, 'Toggle Miranda Rights Card', 'keyboard', Config.DefaultKeybind)

-- =========================
-- DISPLAY HANDLER
-- =========================
function SetDisplay(state)
    if display == state then return end
    display = state

    SetNuiFocus(state, false)
    SetNuiFocusKeepInput(true)

    if state then
        PlayHoldingAnim()
    else
        StopHoldingAnim()
    end

    SendNUIMessage({
        type = "ui",
        status = state,
        config = {
            rights = mirandaRights,
            uiSettings = uiSettings
        }
    })

    print('[Miranda Rights] Display set to: ' .. tostring(state))
end

-- =========================
-- NUI CLOSE BUTTON
-- =========================
RegisterNUICallback('close', function(_, cb)
    SetDisplay(false)
    cb('ok')
end)

-- =========================
-- EXPORTS
-- =========================
exports('showMirandaCard', function()
    if HasAllowedJob() then
        SetDisplay(true)
        return true
    end
    return false
end)

exports('hideMirandaCard', function()
    SetDisplay(false)
end)

exports('canUseMirandaCard', function()
    return HasAllowedJob()
end)
