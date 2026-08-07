function gsv(name) return game:GetService(name) end
function ins(...) return Instance.new(...) end
local core = gsv"CoreGui"
local rs = gsv"RunService"
local ui_t = {}
_G.ntf_content = ""
ui_t.screen = ins("ScreenGui", core)
ui_t.btn = ins("TextLabel", ui_t.screen)
ui_t.corner = ins("UICorner", ui_t.btn)
ui_t.stroke = ins("UIStroke", ui_t.btn)
ui_t.pre = " Thông báo:\n"
ui_t.is_fading = false
ui_t.event = nil
ui_t.current = 1
ui_t.adjust = 100

local b = ui_t.btn
ui_t.screen.Name = "NEW_UPDATES_NOTIFY"
b.Name = "New:Events"
b.BackgroundTransparency = 0.5
b.BackgroundColor3 = Color3.new(0, 0, 0)
b.Position = UDim2.new(0.2, 0, 0.2, 0)
b.Size = UDim2.new(0.6, 0, 0.4, 0)
b.TextScaled = false
b.TextSize = 12
b.TextColor3 = Color3.new(1, 1, 1)
b.Text = ui_t.pre
b.Font = Enum.Font.Code
b.TextXAlignment = "Left"
b.TextYAlignment = "Top"
b.Visible = false
ui_t.corner.CornerRadius = UDim.new(0.05, 0)
ui_t.stroke.Thickness = 2

function re_active_ntf()
  ui_t.event = rs.RenderStepped:Connect(function()
    if _G.ntf_content ~= "" and b.Text == ui_t.pre then
      b.Text = ui_t.pre .. _G.ntf_content .. "\n (Chạm vào để tắt thông báo)"
      if b.Text ~= ui_t.pre then
        b.Visible = true
        ui_t.event:Disconnect()
        ui_t.event = nil
      end
    end
  end)
end

b.MouseLeave:Connect(function()
  if not ui_t.is_fading then ui_t.is_fading = true
    repeat ui_t.current = ui_t.current + 1 task.wait(0.01)
      b.BackgroundTransparency = ui_t.current / ui_t.adjust
    until b.BackgroundTransparency >= 1
    b.Visible = false
    b.Text = ui_t.pre
    ui_t.current = 1
    ui_t.is_fading = false
    _G.ntf_content = ""
    re_active_ntf()
  end
end)

re_active_ntf()
-- This mess... --
