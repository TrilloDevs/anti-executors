RegisterServerEvent('ExecutorDetected')
AddEventHandler('ExecutorDetected', function(reason)
    DropPlayer(source, '[Server]: ' .. tostring(reason) .. '')
end)