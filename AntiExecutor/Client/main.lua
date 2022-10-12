InChecks = {
    [1] = true,
    [2] = false,
    [3] = false,
    [4] = false
}

CreateThread(function()
    local SavedX, SavedY = GetNuiCursorPosition()
    local SavedCamCoords = GetGameplayCamCoord()
    while (true) do
        Wait(0)
        local NewX, NewY = GetNuiCursorPosition()
        local NewCamCoords = GetGameplayCamCoord()
        local ResX, ResY = GetActiveScreenResolution()
        if (NewX <= ResX and NewY <= ResY) then
            if (InChecks[1] == true) then
                if IsControlJustPressed(0, 121) then
                    InChecks[4] = true
                    CreateThread(function()
                        while (InChecks[4] == true) do
                            Wait(0)
                            if (NewX ~= SavedX or NewY ~= SavedY) then
                                if (not IsNuiFocused()) then
                                    TriggerServerEvent('ExecutorDetected', 'Executor Detected (V1)')
                                end
                            elseif (NewCamCoords ~= SavedCamCoords) then
                                InChecks[4] = false
                            end
                        end
                    end)
                end
            end
        end
        SavedX, SavedY = NewX, NewY
        SavedCamCoords = NewCamCoords
    end
end)

CreateThread(function()
    local SavedX, SavedY = GetNuiCursorPosition()
    local SavedCamCoords = GetGameplayCamCoord()
    while (true) do
        Wait(0)
        local NewX, NewY = GetNuiCursorPosition()
        local NewCamCoords = GetGameplayCamCoord()
        local ResX, ResY = GetActiveScreenResolution()
        local Sent = 0
        if (NewX <= ResX and NewY <= ResY) then
            if (InChecks[1] == true) then
                if (NewX ~= SavedX or NewY ~= SavedY) then
                    if (NewCamCoords ~= SavedCamCoords) then
                        if (not IsNuiFocused()) then
                            InChecks[1] = false
                            InChecks[2] = true
                        end
                    end
                end
            elseif (InChecks[2] == true) then
                if IsControlJustPressed(0, 121) then
                    InChecks[2] = false
                    InChecks[3] = true
                else
                    if (NewX ~= SavedX or NewY ~= SavedY) then
                        if (NewCamCoords == SavedCamCoords) then
                            InChecks[1] = true
                            InChecks[2] = false
                        end
                    end
                end
            elseif (InChecks[3] == true) then
                for i = 1, 5 do
                    if IsControlJustPressed(i, 240) then
                        Sent = Sent + 1
                    end
                end
                if (Sent == 5) then
                    InChecks[2] = true
                    InChecks[3] = false
                end
                if (NewX ~= SavedX or NewY ~= SavedY) then
                    if (NewCamCoords == SavedCamCoords) then
                        InChecks[1] = true
                        InChecks[2] = false
                        InChecks[3] = false
                        TriggerServerEvent('ExecutorDetected', 'Executor Detected (V2)')
                    end
                end
            end
        end
        SavedX, SavedY = NewX, NewY
        SavedCamCoords = NewCamCoords
    end
end)