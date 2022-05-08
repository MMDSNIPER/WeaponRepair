local ox_inventory = exports.ox_inventory

lib.callback.register('WRepair:Cost', function(weapon)
    local weapon = ox_inventory:GetCurrentWeapon(source)
    if weapon then
        ox_inventory:RemoveItem(source, 'repairkit_weapon', 1)
        ox_inventory:SetDurability(source, weapon.slot, 100)
        return true
    end
    return false
end)