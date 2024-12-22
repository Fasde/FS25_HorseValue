HorseValue = {}
HorseValue.name = g_currentModName
HorseValue.path = g_currentModDirectory

HorseValue.newBuyPrices = {}
table.insert(HorseValue.newBuyPrices, 0, 1000)
table.insert(HorseValue.newBuyPrices, 36, 20000)
table.insert(HorseValue.newBuyPrices, 60, 12500)

HorseValue.newSellPrices = {}
table.insert(HorseValue.newSellPrices, 0, 500)
table.insert(HorseValue.newSellPrices, 36, 15000)
table.insert(HorseValue.newSellPrices, 60, 10000)

function HorseValue:loadAnimals()
    if self.isServer then
        for _, subTypeIndex in ipairs(g_currentMission.animalSystem.nameToType['HORSE'].subTypes) do
            local subType = g_currentMission.animalSystem.subTypes[subTypeIndex]

            for _2, buyPrice in ipairs(subType.buyPrice.keyframes) do
                local time = buyPrice.time
                buyPrice[1] = HorseValue.newBuyPrices[time]
                printf('-- HorseValue: %s buyPrice for time:%s set to:%s', subType.name, time, HorseValue.newBuyPrices[time])
            end

            for _3, sellPrice in ipairs(subType.sellPrice.keyframes) do
                local time = sellPrice.time
                sellPrice[1] = HorseValue.newSellPrices[time]
                printf('-- HorseValue: %s sellPrice for time:%s set to:%s', subType.name, time, HorseValue.newSellPrices[time])
            end
        end
    end
end

AnimalSystem.loadAnimals = Utils.appendedFunction(AnimalSystem.loadAnimals, HorseValue.loadAnimals)