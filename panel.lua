-- واجهة SGB ULTRA المتكاملة - النسخة الشاملة والأخيرة المصلحة بالملي
local SG = Instance.new("ScreenGui")
SG.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
SG.ResetOnSpawn = false

local MF = Instance.new("Frame")
local LP = Instance.new("Frame")
local RP = Instance.new("Frame")
local TL = Instance.new("TextLabel")
local UC = Instance.new("UICorner")

local Pgs = {}
local Conns = {}
local Tgl = {E = false, P = false, V = false}
local Bck = {M = {}, T = {}, S = {}, X = {}}
local Tabs = {}
local Lbls = {}
local TglB = {}
local ThBtns = {}
local CurrentKey = "O"
local CurScale = 1.0

-- إعدادات اللوحة الرئيسية والبرواز الكلي
MF.Name = "SGB_Mega_Panel_Final"
MF.Parent = SG
MF.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MF.Position = UDim2.new(0.2, 0, 0.15, 0)
MF.Size = UDim2.new(0, 650, 0, 450)
MF.Active = true
MF.Draggable = true

local MC = UC:Clone()
MC.CornerRadius = UDim.new(0, 14)
MC.Parent = MF

-- إعدادات اللوحة الجانبية حقت القوائم حقتك
LP.Parent = MF
LP.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
LP.Size = UDim2.new(0, 180, 1, 0)

local LC = UC:Clone()
LC.CornerRadius = UDim.new(0, 14)
LC.Parent = LP

TL.Parent = LP
TL.BackgroundTransparency = 1
TL.Size = UDim2.new(1, 0, 0, 50)
TL.Text = "🌟 SGB ULTRA"
TL.TextColor3 = Color3.fromRGB(255, 255, 255)
TL.TextSize = 18
TL.Font = Enum.Font.SourceSansBold

-- إعدادات اللوحة اليمنى لعرض محتويات القوائم
RP.Parent = MF
RP.BackgroundTransparency = 1
RP.Position = UDim2.new(0, 190, 0, 10)
RP.Size = UDim2.new(0, 450, 0, 430)

local function CP(n)
    local PF = Instance.new("ScrollingFrame")
    PF.Parent = RP
    PF.Size = UDim2.new(1, 0, 1, 0)
    PF.BackgroundTransparency = 1
    PF.CanvasSize = UDim2.new(0, 0, 2.5, 0)
    PF.ScrollBarThickness = 4
    PF.Visible = false
    Pgs[n] = PF
    return PF
end

local M_S = CP("M")
local F_F = CP("F")
local T_P = CP("T")
local btnY = 60

-- [تثبيت نظام تلوين أزرار القوائم الجانبية النشطة باللون الأخضر الغامق وتصفير الباقي بالملي]
local function CT(t, p)
    local b = Instance.new("TextButton")
    b.Parent = LP
    b.Size = UDim2.new(0, 150, 0, 40)
    b.Position = UDim2.new(0, 15, 0, btnY)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    b.Text = t
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.SourceSansBold
    btnY = btnY + 50
    local c = UC:Clone()
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    table.insert(Tabs, b)
    
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(Pgs) do v.Visible = false end
        p.Visible = true
        for _, x in pairs(Tabs) do x.BackgroundColor3 = Color3.fromRGB(20, 20, 25) end
        b.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    end)
end

CT("⚙️ إعدادات الإخفاء الدقيقة", M_S)
CT("⚡ اعدادات الفاست فلاج", F_F)
CT("🎨 تخصيص الواجهه", T_P)
Tabs[1].BackgroundColor3 = Color3.fromRGB(40, 120, 40)

-- زر إغلاق السكربت الكلي الأحمر بأسفل اللوحة الجانبية
local CB = Instance.new("TextButton")
CB.Parent = LP
CB.Size = UDim2.new(0, 150, 0, 35)
CB.Position = UDim2.new(0, 15, 1, -50)
CB.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
CB.Text = "إغلاق السكربت"
CB.TextColor3 = Color3.fromRGB(255, 255, 255)
CB.TextSize = 13
CB.Font = Enum.Font.SourceSansBold
local cc = UC:Clone()
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = CB
CB.MouseButton1Click:Connect(function() SG:Destroy() end)

-- دالة بناء التوجلز العادية حقت التفعيل والتعطيل (للإخفاء والفاست فلاج)
local function C_E(p, t, y, m, cb)
    local l = Instance.new("TextLabel")
    l.Parent = p l.Size = UDim2.new(0, 240, 0, 30) l.Position = UDim2.new(0, 10, 0, y) l.BackgroundTransparency = 1
    l.Text = "⬅️ " .. t l.TextColor3 = Color3.fromRGB(255, 255, 255) l.TextSize = 13 l.TextXAlignment = Enum.TextXAlignment.Left table.insert(Lbls, l)
    
    local b = Instance.new("TextButton")
    b.Parent = p b.Size = UDim2.new(0, 110, 0, 26) b.Position = UDim2.new(0, 310, 0, y)
    b.TextColor3 = Color3.fromRGB(255, 255, 255) b.TextSize = 12 b.Font = Enum.Font.SourceSansBold b.TextXAlignment = Enum.TextXAlignment.Center table.insert(TglB, b)
    local c = UC:Clone() c.CornerRadius = UDim.new(0, 6) c.Parent = b
    
    if m == "B" then
        b.BackgroundColor3 = t:find("تكبير") and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(150, 40, 40)
        b.Text = t:find("تكبير") and "تكبير ➕" or "تصغير ➖"
        b.MouseButton1Click:Connect(function()
            b.BackgroundColor3 = t:find("تكبير") and Color3.fromRGB(20, 80, 20) or Color3.fromRGB(100, 20, 20)
            task.wait(0.1)
            b.BackgroundColor3 = t:find("تكبير") and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(150, 40, 40)
            cb()
        end)
    else
        b.BackgroundColor3 = Color3.fromRGB(100, 40, 40) b.Text = "تعطيل ❌" local e = false
        b.MouseButton1Click:Connect(function()
            e = not e b.BackgroundColor3 = e and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(100, 40, 40)
            b.Text = e and "تفعيل ✔️" or "تعطيل ❌" cb(e)
        end)
    end
end

local function isP(o)
    local Pl = game:GetService("Players")
    if o:IsDescendantOf(Pl) or o:FindFirstChildOfClass("Humanoid") or (o.Parent and o.Parent:FindFirstChildOfClass("Humanoid")) then return true end
    if o.Name:lower() == "baseplate" or o.Name:lower() == "floor" or (o:IsA("BasePart") and (o.Size.X >= 500 or o.Size.Z >= 500)) then return true end
    return false
end

local function checkE(v)
    if not Tgl.E then return end
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Beam") or v:IsA("Sparkles") then
        v:Destroy()
    elseif v:IsA("MeshPart") or v:IsA("SpecialMesh") then
        local nl = v.Name:lower()
        if nl:find("fx") or nl:find("effect") or nl:find("hit") or nl:find("slash") or nl:find("shock") then v:Destroy() end
    end
end

local function updateO(o, t, m)
    if not o or isP(o) then return end
    local n, p = o.Name:lower(), (o.Parent and o.Parent:FindFirstChildOfClass("Humanoid") and "player" or o.Parent and o.Parent.Name:lower() or "")
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
                o.Size = Vector3.new(0, 0, 0) o.Transparency = 1
            else
                if Bck.S[o] then o.Size = Bck.S[o] o.Transparency = Bck.T[o] end
            end
        elseif o:IsA("SpecialMesh") then
            if m then
                if not Bck.X[o] then Bck.X[o] = o.Scale end
                o.Scale = Vector3.new(0, 0, 0)
            else
                if Bck.X[o] then o.Scale = Bck.X[o] end
            end
        end
    end
end

-- دالة الصبغ الشامل لصبغ البرواز والحواف والرموز والخطوط بالملي
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
    CurScale = math.clamp(s, 0.75, 1.4) MF.Size = UDim2.new(0, 650 * CurScale, 0, 450 * CurScale) RP.Size = UDim2.new(0, 450 * CurScale, 0, 430 * CurScale) TL.TextSize = 18 * CurScale
    for _, x in pairs(Tabs) do x.TextSize = 13 * CurScale end for _, x in pairs(Lbls) do x.TextSize = 13 * CurScale end for _, x in pairs(TglB) do x.TextSize = 12 * CurScale end
end

-- [مكونات صفحة 1: إعدادات الإخفاء الدقيقة]
C_E(M_S, "إخفاء مؤثرات الضربات والكومبو تماماً", 15, "T", function(v) Tgl.E = v if v then for _, o in pairs(workspace:GetDescendants()) do checkE(o) end if workspace.CurrentCamera then for _, o in pairs(workspace.CurrentCamera:GetDescendants()) do checkE(o) end end if #Conns == 0 then table.insert(Conns, workspace.DescendantAdded:Connect(function(o) task.defer(checkE, o) end)) if workspace.CurrentCamera then table.insert(Conns, workspace.CurrentCamera.DescendantAdded:Connect(function(o) task.defer(checkE, o) end)) end end else for _, c in pairs(Conns) do if c then c:Disconnect() end end table.clear(Conns) end end)
C_E(M_S, "إخفاء الديكور حول الماب", 55, "T", function(v) Tgl.P = v for _, o in pairs(workspace:GetDescendants()) do updateO(o, "Props", v) end end)
C_E(M_S, "إزالة كل النباتات", 95, "T", function(v) Tgl.V = v for _, o in pairs(workspace:GetDescendants()) do updateO(o, "Veg", v) end end)

-- [مكونات صفحة 2: فاست فلاج الماب]
