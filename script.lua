-- Mercury Premium Script
-- Server Script เพื่อตรวจสอบ Key และ HWID

-- ตัวแปรสำหรับเก็บค่า API
local API_URL = "https://1e055f9e-f156-45d8-bef8-849e084d4bcb-00-28820ezsh3ku2.pike.replit.dev/api/token/verify" -- แก้ไขเป็น URL API ของคุณ

-- ฟังก์ชันสำหรับส่งคำขอ HTTP POST
local function verifyKeyAndHWID(key, hwid)
    local httpService = game:GetService("HttpService")
    
    local data = {
        key = key,
        hwid = hwid
    }
    
    local success, response = pcall(function()
        return httpService:PostAsync(
            API_URL,
            httpService:JSONEncode(data),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
    
    if not success then
        return false, "Failed to connect to verification server"
    end
    
    local result = httpService:JSONDecode(response)
    return result.success, result.message
end

-- ฟังก์ชันหลักสำหรับตรวจสอบผู้ใช้
local function validateUser()
    -- ตรวจสอบว่ามีค่า Key และ HWID หรือไม่
    if not _G.KeyLocal or not _G.HWID then
        return false, "Missing Key or HWID"
    end
    
    -- ส่งคำขอไปยัง API เพื่อตรวจสอบ
    local success, message = verifyKeyAndHWID(_G.KeyLocal, _G.HWID)
    
    return success, message
end

-- เริ่มต้นสคริปต์
-- ส่วนนี้จะทำงานเมื่อสคริปต์ถูกเรียกใช้
local success, message = validateUser()

if not success then
    -- หากการตรวจสอบไม่ผ่าน ให้เตะผู้เล่นออกจากเกม
    local player = game.Players.LocalPlayer
    player:Kick("[Mercury Premium] Authentication failed: " .. message)
    return -- หยุดการทำงานของสคริปต์
end

-- หากผ่านการตรวจสอบ ให้เริ่มทำงานส่วนหลักของสคริปต์
print("[Mercury Premium] Authentication successful!")

-- เริ่มต้นสคริปต์หลักจากตรงนี้
--==================================--
--  ส่วนของฟีเจอร์สคริปต์หลักของคุณ  --
--==================================--

-- ฟังก์ชันตัวอย่างสำหรับ ESP
local function createESP()
    print("Creating ESP...")
    -- โค้ด ESP ของคุณที่นี่
end

-- ฟังก์ชันตัวอย่างสำหรับ Aimbot
local function createAimbot()
    print("Creating Aimbot...")
    -- โค้ด Aimbot ของคุณที่นี่
end

-- สร้าง UI สำหรับควบคุม
local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local ESPButton = Instance.new("TextButton")
    local AimbotButton = Instance.new("TextButton")
    
    -- ตั้งค่า ScreenGui
    ScreenGui.Name = "MercuryPremium"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- ตั้งค่า Frame
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.8, 0, 0.5, 0)
    Frame.Size = UDim2.new(0, 200, 0, 120)
    Frame.Active = true
    Frame.Draggable = true
    
    -- ตั้งค่า Title
    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Mercury Premium"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16.000
    
    -- ตั้งค่า ESPButton
    ESPButton.Name = "ESPButton"
    ESPButton.Parent = Frame
    ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ESPButton.BorderSizePixel = 0
    ESPButton.Position = UDim2.new(0.1, 0, 0.35, 0)
    ESPButton.Size = UDim2.new(0.8, 0, 0, 25)
    ESPButton.Font = Enum.Font.SourceSans
    ESPButton.Text = "Toggle ESP"
    ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPButton.TextSize = 14.000
    
    -- ตั้งค่า AimbotButton
    AimbotButton.Name = "AimbotButton"
    AimbotButton.Parent = Frame
    AimbotButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AimbotButton.BorderSizePixel = 0
    AimbotButton.Position = UDim2.new(0.1, 0, 0.65, 0)
    AimbotButton.Size = UDim2.new(0.8, 0, 0, 25)
    AimbotButton.Font = Enum.Font.SourceSans
    AimbotButton.Text = "Toggle Aimbot"
    AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimbotButton.TextSize = 14.000
    
    -- เพิ่ม Event สำหรับปุ่ม
    local espEnabled = false
    ESPButton.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        if espEnabled then
            ESPButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            createESP()
        else
            ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            -- ปิด ESP
        end
    end)
    
    local aimbotEnabled = false
    AimbotButton.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            AimbotButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            createAimbot()
        else
            AimbotButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            -- ปิด Aimbot
        end
    end)
end

-- เริ่มต้นทำงาน
createUI()
print("[Mercury Premium] Script loaded successfully!")