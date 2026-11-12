-- Sakura Social Hub: procedural two-storey Japanese-inspired social building.
-- Rojo maps this Script into ServerScriptService.
-- Geometry is generated at server start. Edit the CONFIG section to customize it.

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local CONFIG = {
    BaseY = 0,
    FloorSize = Vector3.new(120, 2, 90),
    WallHeight = 18,
    WallThickness = 2,
    Wood = Color3.fromRGB(111, 63, 43),
    Cream = Color3.fromRGB(239, 224, 194),
    Dark = Color3.fromRGB(42, 38, 39),
    Red = Color3.fromRGB(151, 45, 49),
    Pink = Color3.fromRGB(255, 166, 190),
    Green = Color3.fromRGB(93, 133, 104),
}

local old = Workspace:FindFirstChild("SakuraSocialHub_Generated")
if old then old:Destroy() end

local model = Instance.new("Model")
model.Name = "SakuraSocialHub_Generated"
model.Parent = Workspace

local function part(name, size, cf, color, material, parent)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cf
    p.Anchored = true
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    p.Color = color
    p.Material = material or Enum.Material.SmoothPlastic
    p.Parent = parent or model
    return p
end

local function pointLight(parent, color, brightness, range)
    local light = Instance.new("PointLight")
    light.Color = color
    light.Brightness = brightness
    light.Range = range
    light.Shadows = true
    light.Parent = parent
end

local function neonLantern(position)
    local frame = part("LanternFrame", Vector3.new(2.2, 3.2, 2.2),
        CFrame.new(position), CONFIG.Red, Enum.Material.Wood)
    local glow = part("LanternGlow", Vector3.new(1.55, 2.35, 1.55),
        CFrame.new(position), Color3.fromRGB(255, 190, 130), Enum.Material.Neon)
    glow.Transparency = 0.18
    pointLight(glow, Color3.fromRGB(255, 166, 105), 1.4, 18)
    part("LanternCap", Vector3.new(2.6, 0.35, 2.6),
        CFrame.new(position + Vector3.new(0, 1.75, 0)), CONFIG.Dark, Enum.Material.Wood)
end

local function seat(name, position, color)
    local base = part(name .. "_Seat", Vector3.new(7, 1, 3),
        CFrame.new(position), color, Enum.Material.Wood)
    part(name .. "_Back", Vector3.new(7, 3, 0.8),
        CFrame.new(position + Vector3.new(0, 1.7, 1.1)), color, Enum.Material.Wood)
    return base
end

local function tableSet(position)
    part("LowTable", Vector3.new(5, 0.6, 3),
        CFrame.new(position + Vector3.new(0, 1.5, 0)), CONFIG.Wood, Enum.Material.Wood)
    for _, offset in ipairs({
        Vector3.new(-2, 0, -1), Vector3.new(2, 0, -1),
        Vector3.new(-2, 0, 1), Vector3.new(2, 0, 1)
    }) do
        part("TableLeg", Vector3.new(0.35, 1.5, 0.35),
            CFrame.new(position + offset + Vector3.new(0, 0.75, 0)), CONFIG.Dark, Enum.Material.Wood)
    end
    seat("BenchA", position + Vector3.new(0, 0.6, -4), CONFIG.Wood)
    seat("BenchB", position + Vector3.new(0, 0.6, 4), CONFIG.Wood)
end

-- Site, garden and main ground floor.
part("Foundation", Vector3.new(150, 2, 120), CFrame.new(0, -1, 0), CONFIG.Dark, Enum.Material.Slate)
part("GroundFloor", CONFIG.FloorSize, CFrame.new(0, 0, 0), CONFIG.Cream, Enum.Material.WoodPlanks)

-- Perimeter walls with a wide front entrance.
part("BackWall", Vector3.new(120, 18, 2), CFrame.new(0, 9, -44), CONFIG.Wood, Enum.Material.Wood)
part("LeftWall", Vector3.new(2, 18, 90), CFrame.new(-59, 9, 0), CONFIG.Wood, Enum.Material.Wood)
part("RightWall", Vector3.new(2, 18, 90), CFrame.new(59, 9, 0), CONFIG.Wood, Enum.Material.Wood)
part("FrontLeft", Vector3.new(38, 18, 2), CFrame.new(-41, 9, 44), CONFIG.Wood, Enum.Material.Wood)
part("FrontRight", Vector3.new(38, 18, 2), CFrame.new(41, 9, 44), CONFIG.Wood, Enum.Material.Wood)
part("EntranceHeader", Vector3.new(44, 3, 3), CFrame.new(0, 16.5, 44), CONFIG.Red, Enum.Material.Wood)

-- Shoji-inspired window panels along side walls.
for z = -30, 30, 15 do
    for _, x in ipairs({-57.7, 57.7}) do
        local glass = part("ShojiWindow", Vector3.new(0.35, 8, 10),
            CFrame.new(x, 9, z), Color3.fromRGB(255, 226, 190), Enum.Material.Glass)
        glass.Transparency = 0.35
    end
end

-- Central open lounge.
for _, z in ipairs({-22, -7, 8, 23}) do
    tableSet(Vector3.new(0, 0, z))
end

-- Café counter and stools on the right.
part("CafeCounter", Vector3.new(24, 4, 5), CFrame.new(35, 2, -28), CONFIG.Wood, Enum.Material.Wood)
part("CafeBackBar", Vector3.new(24, 7, 2), CFrame.new(35, 5.5, -34), CONFIG.Dark, Enum.Material.Wood)
for x = 25, 45, 10 do
    part("CafeStool", Vector3.new(2, 2, 2), CFrame.new(x, 1, -20), CONFIG.Red, Enum.Material.Wood)
end

-- Staircase at rear-left: broad, walkable steps.
for i = 0, 11 do
    part("StairStep", Vector3.new(16, 1, 4),
        CFrame.new(-40, 1 + i * 1.35, -30 + i * 3.1), CONFIG.Wood, Enum.Material.WoodPlanks)
end

-- Upper floor, leaving a central atrium opening.
part("UpperLeft", Vector3.new(38, 2, 50), CFrame.new(-40, 19, -8), CONFIG.Cream, Enum.Material.WoodPlanks)
part("UpperRight", Vector3.new(38, 2, 50), CFrame.new(40, 19, -8), CONFIG.Cream, Enum.Material.WoodPlanks)
part("UpperBack", Vector3.new(42, 2, 20), CFrame.new(0, 19, -34), CONFIG.Cream, Enum.Material.WoodPlanks)
part("UpperFront", Vector3.new(42, 2, 12), CFrame.new(0, 19, 36), CONFIG.Cream, Enum.Material.WoodPlanks)

-- Balcony rails around atrium.
for x = -18, 18, 6 do
    part("BalconyRail", Vector3.new(5.8, 2, 0.6), CFrame.new(x, 21, -17), CONFIG.Red, Enum.Material.Wood)
    part("BalconyRail", Vector3.new(5.8, 2, 0.6), CFrame.new(x, 21, 17), CONFIG.Red, Enum.Material.Wood)
end

-- Upstairs quiet lounge seating.
for _, pos in ipairs({
    Vector3.new(-40, 20, -18), Vector3.new(-40, 20, 2),
    Vector3.new(40, 20, -18), Vector3.new(40, 20, 2)
}) do
    tableSet(pos)
end

-- Roof eaves and layered Japanese-inspired roof silhouette.
part("RoofMain", Vector3.new(132, 3, 102), CFrame.new(0, 31, 0), CONFIG.Dark, Enum.Material.Slate)
part("RoofRidge", Vector3.new(136, 2, 5), CFrame.new(0, 33, 0), CONFIG.Red, Enum.Material.Wood)
part("RoofFrontEave", Vector3.new(138, 1, 8), CFrame.new(0, 29, 48), CONFIG.Red, Enum.Material.Wood)
part("RoofBackEave", Vector3.new(138, 1, 8), CFrame.new(0, 29, -48), CONFIG.Red, Enum.Material.Wood)

-- Exterior lanterns and a simple sakura garden.
for _, pos in ipairs({
    Vector3.new(-68, 5, 38), Vector3.new(68, 5, 38),
    Vector3.new(-68, 5, -38), Vector3.new(68, 5, -38),
    Vector3.new(-20, 5, 62), Vector3.new(20, 5, 62)
}) do
    neonLantern(pos)
end

-- Koi pond and stepping stones.
part("KoiPond", Vector3.new(30, 1, 18), CFrame.new(0, 0, 70), Color3.fromRGB(45, 104, 119), Enum.Material.Glass)
for i = 1, 7 do
    part("SteppingStone", Vector3.new(4, 0.5, 4),
        CFrame.new(-18 + i * 5, 0.8, 58), Color3.fromRGB(130, 130, 125), Enum.Material.Slate)
end

-- Cherry blossom trees: stylized trunks and clustered pink canopies.
for _, x in ipairs({-48, -30, 30, 48}) do
    local z = 70
    part("SakuraTrunk", Vector3.new(2, 13, 2), CFrame.new(x, 6.5, z), CONFIG.Wood, Enum.Material.Wood)
    for _, offset in ipairs({
        Vector3.new(0, 10, 0), Vector3.new(5, 8, 0),
        Vector3.new(-5, 8, 1), Vector3.new(0, 8, 5)
    }) do
        local blossom = part("SakuraBlossom", Vector3.new(9, 7, 9),
            CFrame.new(x + offset.X, offset.Y, z + offset.Z), CONFIG.Pink, Enum.Material.Grass)
        blossom.Shape = Enum.PartType.Ball
    end
end

-- Spawn point just inside the main entrance.
local spawn = Instance.new("SpawnLocation")
spawn.Name = "SakuraHubSpawn"
spawn.Size = Vector3.new(8, 1, 8)
spawn.CFrame = CFrame.new(0, 1.5, 34)
spawn.Anchored = true
spawn.Neutral = true
spawn.Color = CONFIG.Red
spawn.Material = Enum.Material.Neon
spawn.Parent = model

-- Lighting mood.
Lighting.ClockTime = 19.2
Lighting.Brightness = 2
Lighting.Ambient = Color3.fromRGB(115, 105, 125)
Lighting.OutdoorAmbient = Color3.fromRGB(75, 76, 105)
Lighting.EnvironmentDiffuseScale = 0.35
Lighting.EnvironmentSpecularScale = 0.5

local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
atmosphere.Density = 0.28
atmosphere.Offset = 0.15
atmosphere.Color = Color3.fromRGB(190, 180, 210)
atmosphere.Decay = Color3.fromRGB(95, 80, 110)
atmosphere.Parent = Lighting

print("Sakura Social Hub generated. Enable Voice Chat in the experience Communication settings.")
