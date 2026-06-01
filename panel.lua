-- SGB ULTRA MASTER PANEL - RE-ENGINEERED 100% CLEAN SOURCE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

local Pages = {}
local TogglesState = { Effects = false, Props = false, Vegetation = false }
local BackupData = { Materials = {}, Transparency = {}, MeshSizes = {}, SpecialScales = {} }
local CustomConnections = {}
local TabButtons = {}
local LabelsList = {}
local TogglesButtonsList = {}

local CurrentKey = "O"
local CurScale = 1.0

MainFrame.Name = "SGB_Master_Panel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 650, 0, 450)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = UICorner:Clone()
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
LeftPanel.Size = UDim2.new(0, 180, 1, 0)

local LeftCorner = UICorner:Clone()
LeftCorner.CornerRadius = UDim.new(0, 14)
LeftCorner.Parent = LeftPanel

Title.Parent = LeftPanel
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🌟 SGB ULTRA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

RightPanel.Parent = MainFrame
RightPanel.BackgroundTransparency = 1
RightPanel.Position = UDim2.new(0, 190, 0, 10)
RightPanel.Size = UDim2.new(0, 450, 0, 430)

local function CreatePage(name)
    local PageFrame = Instance.new("ScrollingFrame")
    PageFrame.Parent = RightPanel
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.BackgroundTransparency = 1
    PageFrame.CanvasSize = UDim2.new(0, 0, 2.5, 0)
    PageFrame.ScrollBarThickness = 4
    PageFrame.Visible = false
    Pages[name] = PageFrame
    return PageFrame
end

local MainSettingsPage = CreatePage("MainSettings")
local FastFlagsPage = CreatePage("FastFlags")
local ThemePage = CreatePage("Theme")

local btnY = 60
local function CreateTabButton(text, pageFrame)
    local btn = Instance.new("TextButton")
    btn.Parent = LeftPanel
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, btnY)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    
    local c = UICorner:Clone()
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    btnY = btnY + 50
    table.insert(TabButtons, btn)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        pageFrame.Visible = true
        for _, x in pairs(TabButtons) do x.BackgroundColor3 = Color3.fromRGB(20, 20, 25) end
        btn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    end)
end

CreateTabButton("⚙️ إعدادات الإخفاء الدقيقة", MainSettingsPage)
CreateTabButton("⚡ اعدادات الفاست فلاج", FastFlagsPage)
CreateTabButton("🎨 تخصيص الواجهه", ThemePage)
TabButtons[3].BackgroundColor3 = Color3.fromRGB(40, 120, 40)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = LeftPanel
CloseBtn.Size = UDim2.new(0, 150, 0, 35)
CloseBtn.Position = UDim2.new(0, 15, 1, -50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
CloseBtn.Text = "إغلاق السكربت"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.SourceSansBold
local cc = UICorner:Clone()
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local function CreateToggle(parent, text, yPos, callback)
    local label = Instance.new("TextLabel")
    label.Parent = parent label.Size = UDim2.new(0, 240, 0, 30) label.Position = UDim2.new(0, 10, 0, yPos) label.BackgroundTransparency = 1
    label.Text = "⬅️ " .. text label.TextColor3 = Color3.fromRGB(255, 255, 255) label.TextSize = 13 label.TextXAlignment = Enum.TextXAlignment.Left label.Font = Enum.Font.SourceSans table.insert(LabelsList, label)

    local btn = Instance.new("TextButton")
    btn.Parent = parent btn.Size = UDim2.new(0, 110, 0, 26) btn.Position = UDim2.new(0, 310, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(100, 40, 40) btn.Text = "تعطيل ❌" btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.TextSize = 12 btn.Font = Enum.Font.SourceSansBold table.insert(TogglesButtonsList, btn)
    local c = UICorner:Clone() c.CornerRadius = UDim.new(0, 6) c.Parent = btn

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(100, 40, 40)
        btn.Text = enabled and "تفعيل ✔️" or "تعطيل ❌"
        callback(enabled)
    end)
end

local function isProtected(obj)
    local Players = game:GetService("Players")
    if obj:IsDescendantOf(Players) or obj:FindFirstChildOfClass("Humanoid") or (obj.Parent and obj.Parent:FindFirstChildOfClass("Humanoid")) then return true end
    if obj.Name:lower() == "baseplate" or obj.Name:lower() == "floor" or (obj:IsA("BasePart") and (obj.Size.X >= 500 or obj.Size.Z >= 500)) then return true end
    return false
end

local function checkE(v)
    if not Tgl.E then return end
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Beam") or v:IsA("Sparkles") then v:Destroy()
    elseif v:IsA("MeshPart") or v:IsA("SpecialMesh") then
        local nl = v.Name:lower()
        if nl:find("fx") or nl:find("effect") or nl:find("hit") or nl:find("slash") or nl:find("shock") then v:Destroy() end
    end
end

local function updateO(o, t, m)
    if not o or isP(o) then return end
    local n = o.Name:lower()
    local p = o.Parent and o.Parent.Name:lower() or ""
    local ty = false
    if t == "Props" then
        if n:find("chair") or n:find("bench") or n:find("table") or n:find("umbrella") or n:find("picnic") or n:find("prop") or n:find("trash") or p:find("picnic") or p:find("prop") or n:find("chair") then ty = true end
    elseif t == "Veg" then
        if p:find("tree") or p:find("leaf") or n:find("wood") or n:find("tree") or n:find("leaf") or n:find("bush") or p:find("bush") or n:find("grass") then ty = true end
    end
    if ty then
        if o:IsA("MeshPart") or o:IsA("BasePart") then
            if m then
                if not Bck.S[o] then Bck.S[o] = o.Size Bck.T[o] = o.Transparency end
                o.Size = Vector3.new(0,0,0) o.Transparency = 1
            else
                if Bck.S[o] then o.Size = Bck.S[o] o.Transparency = Bck.T[o] end
            end
        elseif o:IsA("SpecialMesh") then
            if m then
                if not Bck.X[o] then Bck.X[o] = o.Scale end
                o.Scale = Vector3.new(0,0,0)
            else
                if Bck.X[o] then o.Scale = Bck.X[o] end
            end
        end
    end
end

local function ApplyTheme(th)
    local m, p, t, b = Color3.fromRGB(20, 20, 25), Color3.fromRGB(30, 30, 38), Color3.fromRGB(255, 255, 255), Color3.fromRGB(20, 20, 25)
    if th == "C" then m = Color3.fromRGB(10, 16, 26) p = Color3.fromRGB(16, 26, 41) t = Color3.fromRGB(0, 180, 255) b = Color3.fromRGB(12, 22, 36)
    elseif th == "M" then m = Color3.fromRGB(6, 6, 8) p = Color3.fromRGB(14, 14, 18) t = Color3.fromRGB(240, 240, 245) b = Color3.fromRGB(10, 10, 12)
    elseif th == "S" then m = Color3.fromRGB(28, 12, 12) p = Color3.fromRGB(41, 16, 16) t = Color3.fromRGB(255, 60, 0) b = Color3.fromRGB(24, 10, 10) end
    MF.BackgroundColor3 = m LP.BackgroundColor3 = p TL.TextColor3 = t
    for _, x in pairs(Lbls) do x.TextColor3 = t end
    for _, x in pairs(Tabs) do if x.BackgroundColor3 ~= Color3.fromRGB(40, 120, 40) then x.BackgroundColor3 = b end x.TextColor3 = t end
    for _, x in pairs(TglB) do if x:IsA("TextButton") and not x.Name:find("Clr") then x.TextColor3 = t if x.Text:find("تفعيل") or x.Text:find("➕") or x.Text:find("➖") then x.BackgroundColor3 = (th == "C" and Color3.fromRGB(0, 130, 200) or th == "S" and Color3.fromRGB(200, 60, 0) or x.Text:find("➖") and Color3.fromRGB(150, 40, 40) or Color3.fromRGB(40, 120, 40)) end end end
end

local function SetSc(s)
    CurScale = math.clamp(s, 0.75, 1.4) MF.Size = UDim2.new(0, 650*CurScale, 0, 450*CurScale) RP.Size = UDim2.new(0, 450*CurScale, 0, 430*CurScale) TL.TextSize = 18*CurScale
    for _, x in pairs(Tabs) do x.TextSize = 13*CurScale end for _, x in pairs(Lbls) do x.TextSize = 13*CurScale end for _, x in pairs(TglB) do x.TextSize = 12*CurScale end
end

CreateToggle(MainSettingsPage, "إخفاء مؤثرات الضربات والكومبو تماماً", 15, function(v) Tgl.E = v if v then for _, o in pairs(workspace:GetDescendants()) do checkE(o) end if workspace.CurrentCamera then for _, o in pairs(workspace:GetDescendants()) do checkE(o) end end if #Conns == 0 then table.insert(Conns, workspace.DescendantAdded:Connect(function(o) task.defer(checkE, o) end)) if workspace.CurrentCamera then table.insert(Conns, workspace.CurrentCamera.DescendantAdded:Connect(function(o) task.defer(checkE, o) end)) end end else for _, c in pairs(Conns) do if c then c:Disconnect() end end table.clear(Conns) end end)
CreateToggle(MainSettingsPage, "إخفاء الديكور حول الماب", 55, function(v) Tgl.P = v for _, o in pairs(workspace:GetDescendants()) do updateO(o, "Props", v) end end)
CreateToggle(MainSettingsPage, "إزالة كل النباتات", 95, function(v) Tgl.V = v for _, o in pairs(workspace:GetDescendants()) do updateO(o, "Veg", v) end end)

CreateToggle(FastFlagsPage, "إيقاف تفعيل الظلال وحسابات الإضاءة العالمية", 15, function(v) game:GetService("Lighting").GlobalShadows = not v end)
