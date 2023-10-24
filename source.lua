local Scarlet = {GUIBind = Enum.KeyCode.Insert, Mouse = game.Players.LocalPlayer:GetMouse()}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

Scarlet.MakeTween = function(self, Tween)
    local CurrentTween = TweenService:Create(Tween[1], TweenInfo.new(Tween[2], Tween[3], Tween[4]), Tween[5])
    CurrentTween:Play()

    return CurrentTween
end

local ScarletMain = Instance.new("ScreenGui")
ScarletMain.Name = "Scarlet - [Main]"
ScarletMain.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScarletMain.Parent = ((checkcaller and checkcaller()) and game.CoreGui) or game.Players.LocalPlayer.PlayerGui

local BlurOn = Instance.new("BlurEffect", game.Lighting)
BlurOn.Size = 0

if shared.__Scarlet and shared.__ScarletBlur then
    shared.__Scarlet:Destroy()
    shared.__Scarlet = nil
    shared.__ScarletBlur:Destroy()
    shared.__ScarletBlur = nil
end

shared.__Scarlet = ScarletMain
shared.__ScarletBlur = BlurOn

local WindowCounts = 0

Scarlet.GetContentsSize = function(self, Contents)
    local SizeY = 0

    for _, Child in pairs(Contents:GetChildren()) do
        if Child:IsA("GuiBase2d") and (not Child.ClassName:find("UI")) then
            SizeY = SizeY + Child.AbsoluteSize.Y
        end
    end

    return SizeY
end

Scarlet.Window = function(self, Options)
    local Options = Options or {}

    Options.Name = Options.Name or "Scarlet"

    local Window = Instance.new("Frame")
    Window.Name = "Window" .. WindowCounts
    Window.Active = true
    Window.Size = UDim2.new(0, 250, 0, 35)
    Window.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Window.Position = UDim2.new(0, 0, 0, 10) + UDim2.new(0, (260 * WindowCounts) + 10, 0, 0)
    Window.BorderSizePixel = 0
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.ClipsDescendants = true
    Window.Parent = ScarletMain

    WindowCounts = WindowCounts + 1

    local WindowCorner = Instance.new("UICorner")
    WindowCorner.Name = "WindowCorner"
    WindowCorner.Parent = Window

    local WindowHeader = Instance.new("Frame")
    WindowHeader.Name = "WindowHeader"
    WindowHeader.Size = UDim2.new(1, 0, 0, 35)
    WindowHeader.BorderColor3 = Color3.fromRGB(255, 255, 255)
    WindowHeader.BorderSizePixel = 0
    WindowHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WindowHeader.Parent = Window

    --[[ Drag system
	local isDragging = false

	Scarlet.Mouse.Move:Connect(
		function()
			if isDragging then
				Scarlet:MakeTween(
					{
						Window,
						0.15,
						Enum.EasingStyle.Sine,
						Enum.EasingDirection.Out,
						{
							Position = UDim2.new(
								0,
								Scarlet.Mouse.X - ScarletMain.AbsolutePosition.X,
								0,
								Scarlet.Mouse.Y - ScarletMain.AbsolutePosition.Y
							)
						}
					}
				)
			end
		end
	)

	WindowHeader.InputBegan:Connect(
		function(Input, GameProcessed)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Window.AnchorPoint =
					Vector2.new(
						(Scarlet.Mouse.X - Window.AbsolutePosition.X) / Window.AbsoluteSize.X,
						(Scarlet.Mouse.Y - Window.AbsolutePosition.Y) / Window.AbsoluteSize.Y
					)
				Window.Position =
					UDim2.new(
						0,
						Scarlet.Mouse.X - Window.Parent.AbsolutePosition.X,
						0,
						Scarlet.Mouse.Y - Window.Parent.AbsolutePosition.Y
					)
				isDragging = true
			end
		end
	)

	WindowHeader.InputEnded:Connect(
		function(Input, GameProcessed)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				isDragging = false
			end
		end
	)
	]]
    WindowHeader.InputBegan:Connect(
        function(Input, gameProc)
            if gameProc then
                return
            end

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Window.Draggable = true
            end
        end
    )

    WindowHeader.InputEnded:Connect(
        function(Input, gameProc)
            if gameProc then
                return
            end

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Window.Draggable = false
            end
        end
    )

    local WindowHeaderCorner = Instance.new("UICorner")
    WindowHeaderCorner.Name = "WindowHeaderCorner"
    WindowHeaderCorner.Parent = WindowHeader

    local HeaderImage = Instance.new("ImageLabel")
    HeaderImage.Name = "HeaderImage"
    HeaderImage.AnchorPoint = Vector2.new(0, 0.5)
    HeaderImage.Size = UDim2.new(0, 20, 0, 20)
    HeaderImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HeaderImage.BackgroundTransparency = 1
    HeaderImage.Position = UDim2.new(0, 0, 0.5, 0)
    HeaderImage.BorderSizePixel = 0
    HeaderImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
    HeaderImage.Image = "rbxassetid://11406683885"
    HeaderImage.Parent = WindowHeader

    local WindowHeaderPadding = Instance.new("UIPadding")
    WindowHeaderPadding.Name = "WindowHeaderPadding"
    WindowHeaderPadding.PaddingLeft = UDim.new(0, 8)
    WindowHeaderPadding.PaddingRight = UDim.new(0, 8)
    WindowHeaderPadding.Parent = WindowHeader

    local HeaderText = Instance.new("TextLabel")
    HeaderText.Name = "HeaderText"
    HeaderText.AnchorPoint = Vector2.new(0, 0.5)
    HeaderText.Size = UDim2.new(1, -20, 0, 25)
    HeaderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HeaderText.BackgroundTransparency = 1
    HeaderText.Position = UDim2.new(0, 20, 0.5, 0)
    HeaderText.BorderSizePixel = 0
    HeaderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderText.FontSize = Enum.FontSize.Size14
    HeaderText.TextSize = 13
    HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderText.Text = Options.Name
    HeaderText.Font = Enum.Font.Gotham
    HeaderText.TextTransparency = 0.2
    HeaderText.TextXAlignment = Enum.TextXAlignment.Left
    HeaderText.Parent = WindowHeader

    local HeaderTextPadding = Instance.new("UIPadding")
    HeaderTextPadding.Name = "HeaderTextPadding"
    HeaderTextPadding.PaddingLeft = UDim.new(0, 5)
    HeaderTextPadding.PaddingRight = UDim.new(0, 10)
    HeaderTextPadding.Parent = HeaderText

    local WindowHeaderDock = Instance.new("Frame")
    WindowHeaderDock.Name = "WindowHeaderDock"
    WindowHeaderDock.AnchorPoint = Vector2.new(1, 0.5)
    WindowHeaderDock.Size = UDim2.new(0, 18, 0, 18)
    WindowHeaderDock.BorderColor3 = Color3.fromRGB(0, 0, 0)
    WindowHeaderDock.BackgroundTransparency = 1
    WindowHeaderDock.Position = UDim2.new(1, 0, 0.5, 0)
    WindowHeaderDock.BorderSizePixel = 0
    WindowHeaderDock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowHeaderDock.Parent = WindowHeader

    local WindowHeaderDockImage = Instance.new("ImageLabel")
    WindowHeaderDockImage.Name = "WindowHeaderDockImage"
    WindowHeaderDockImage.AnchorPoint = Vector2.new(0.5, 0.5)
    WindowHeaderDockImage.Size = UDim2.new(0, 18, 0, 18)
    WindowHeaderDockImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
    WindowHeaderDockImage.BackgroundTransparency = 1
    WindowHeaderDockImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    WindowHeaderDockImage.BorderSizePixel = 0
    WindowHeaderDockImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowHeaderDockImage.ImageColor3 = Color3.fromRGB(150, 150, 150)
    WindowHeaderDockImage.Image = "rbxassetid://12974428978"
    WindowHeaderDockImage.Parent = WindowHeaderDock

    local BottomFix = Instance.new("Frame")
    BottomFix.Name = "BottomFix"
    BottomFix.AnchorPoint = Vector2.new(0.5, 1)
    BottomFix.Size = UDim2.new(1, 16, 0, 8)
    BottomFix.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BottomFix.Position = UDim2.new(0.5, 0, 1, 0)
    BottomFix.BorderSizePixel = 0
    BottomFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BottomFix.BackgroundTransparency = 1
    BottomFix.Parent = WindowHeader

    local WindowContents = Instance.new("ScrollingFrame")
    WindowContents.Name = "WindowContents"
    WindowContents.Size = UDim2.new(1, 0, 1, -35)
    WindowContents.ClipsDescendants = false
    WindowContents.BorderColor3 = Color3.fromRGB(0, 0, 0)
    WindowContents.BackgroundTransparency = 1.01
    WindowContents.Position = UDim2.new(0, 0, 0, 35)
    WindowContents.BorderSizePixel = 0
    WindowContents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowContents.AutomaticCanvasSize = Enum.AutomaticSize.Y
    WindowContents.CanvasSize = UDim2.new(0, 0, 0, 0)
    WindowContents.ScrollBarThickness = 2
    WindowContents.ClipsDescendants = true
    WindowContents.Parent = Window

    local ContentsList = Instance.new("UIListLayout")
    ContentsList.Name = "ContentsList"
    ContentsList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentsList.Parent = WindowContents

    local OldWindowSize, OldWindowRotation = Window.Size, WindowHeaderDockImage.Rotation

    Window.Size = UDim2.new(0, 250, 0, 0)

    UserInputService.InputBegan:Connect(
        function(Input, gameProc)
            if gameProc then
                return
            end

            if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Scarlet.GUIBind then
                if BlurOn.Size == 0 then
                    Scarlet:MakeTween(
                        {
                            WindowHeaderDockImage,
                            0.25,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Rotation = OldWindowRotation}
                        }
                    )
                    Scarlet:MakeTween({BlurOn, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Size = 20}})
                    Scarlet:MakeTween(
                        {Window, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Size = OldWindowSize}}
                    )
                elseif BlurOn.Size == 20 then
                    OldWindowSize = Window.Size
                    OldWindowRotation = WindowHeaderDockImage.Rotation
                    Scarlet:MakeTween(
                        {WindowHeaderDockImage, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Rotation = 0}}
                    )
                    Scarlet:MakeTween({BlurOn, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Size = 0}})
                    Scarlet:MakeTween(
                        {Window, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Size = UDim2.new(0, 250, 0, 0)}}
                    )
                end
            end
        end
    )

    WindowContents:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(
        function()
            if WindowHeaderDockImage.Rotation == 180 then
                Scarlet:MakeTween(
                    {
                        Window,
                        0.3,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {Size = UDim2.new(0, 250, 0, (35 * 2) + Scarlet:GetContentsSize(WindowContents))}
                    }
                )
            end
        end
    )

    WindowHeaderDock.InputBegan:Connect(
        function(Input, gameProc)
            if gameProc then
                return
            end

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                if WindowHeaderDockImage.Rotation == 0 then
                    Scarlet:MakeTween(
                        {BottomFix, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {BackgroundTransparency = 0}}
                    )
                    Scarlet:MakeTween(
                        {WindowHeaderDockImage, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Rotation = 180}}
                    )
                    Scarlet:MakeTween(
                        {
                            Window,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Size = UDim2.new(0, 250, 0, (35 * 2) + Scarlet:GetContentsSize(WindowContents))}
                        }
                    )
                elseif WindowHeaderDockImage.Rotation == 180 then
                    Scarlet:MakeTween(
                        {BottomFix, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {BackgroundTransparency = 1}}
                    )
                    Scarlet:MakeTween(
                        {WindowHeaderDockImage, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Rotation = 0}}
                    )
                    Scarlet:MakeTween(
                        {
                            Window,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Size = UDim2.new(0, 250, 0, 35)}
                        }
                    )
                end
            end
        end
    )

    local WindowF = {}

    local Tables = {}

    local function tableClone(original)
        local copy = {}

        for key, value in pairs(original) do
            copy[key] = value
        end

        return copy
    end

    WindowF.Parent = WindowContents

    WindowF.Ripple = function(self, Options)
        local Options = Options or {}

        Options.Power = Options.Power or 5

        Options.Object.ClipsDescendants = true

        local Circle = Instance.new("Frame")
        Circle.Name = "Circle"
        Circle.AnchorPoint = Vector2.new(0.5, 0.5)
        Circle.Size = UDim2.new(0, 0, 0, 0)
        Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Circle.BorderSizePixel = 0
        Circle.BackgroundColor3 = Color3.fromRGB(255, 45, 45)
        Circle.BackgroundTransparency = 0.5
        Circle.Position =
            UDim2.new(
            0,
            (Scarlet.Mouse.X - Options.Object.AbsolutePosition.X) - 10,
            0,
            Scarlet.Mouse.Y - Options.Object.AbsolutePosition.Y
        )
        Circle.Parent = Options.Object

        local CircleCorner = Instance.new("UICorner")
        CircleCorner.Name = "CircleCorner"
        CircleCorner.CornerRadius = UDim.new(1, 0)
        CircleCorner.Parent = Circle

        local CircleAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        CircleAspectRatioConstraint.Name = "CircleAspectRatioConstraint"
        CircleAspectRatioConstraint.Parent = Circle

        Scarlet:MakeTween(
            {
                Circle,
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                {BackgroundTransparency = 1, Size = UDim2.new(Options.Power, 0, Options.Power, 0)}
            }
        )

        wait(1)
        Circle:Destroy()
    end

    WindowF.Folder = function(self, Options)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Folder"

        local FolderF = tableClone(WindowF)

        local Folder = Instance.new("Frame")
        Folder.Name = "Folder" .. Options.Name
        Folder.Size = UDim2.new(1, 0, 0, 25)
        Folder.ClipsDescendants = true
        Folder.BorderColor3 = Color3.fromRGB(255, 255, 255)
        Folder.BorderSizePixel = 0
        Folder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Folder.Parent = Parent

        local FolderImage = Instance.new("ImageLabel")
        FolderImage.Name = "FolderImage"
        FolderImage.Size = UDim2.new(0, 15, 0, 15)
        FolderImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        FolderImage.BackgroundTransparency = 1
        FolderImage.Position = UDim2.new(0, 0, 0, 5)
        FolderImage.BorderSizePixel = 0
        FolderImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FolderImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
        FolderImage.Image = "rbxassetid://11295287370"
        FolderImage.Parent = Folder

        local FolderPadding = Instance.new("UIPadding")
        FolderPadding.Name = "FolderPadding"
        FolderPadding.PaddingLeft = UDim.new(0, 10)
        FolderPadding.Parent = Folder

        local FolderDock = Instance.new("Frame")
        FolderDock.Name = "FolderDock"
        FolderDock.AnchorPoint = Vector2.new(1, 0)
        FolderDock.Size = UDim2.new(0, 15, 0, 15)
        FolderDock.BorderColor3 = Color3.fromRGB(0, 0, 0)
        FolderDock.BackgroundTransparency = 1
        FolderDock.Position = UDim2.new(1, -10, 0, 5)
        FolderDock.BorderSizePixel = 0
        FolderDock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FolderDock.Parent = Folder

        local FolderDockImage = Instance.new("ImageLabel")
        FolderDockImage.Name = "FolderDockImage"
        FolderDockImage.AnchorPoint = Vector2.new(0.5, 0.5)
        FolderDockImage.Size = UDim2.new(0, 15, 0, 15)
        FolderDockImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        FolderDockImage.BackgroundTransparency = 1
        FolderDockImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        FolderDockImage.BorderSizePixel = 0
        FolderDockImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FolderDockImage.ImageColor3 = Color3.fromRGB(150, 150, 150)
        FolderDockImage.Image = "rbxassetid://12974428978"
        FolderDockImage.Parent = FolderDock

        local FolderContents = Instance.new("Frame")
        FolderContents.Name = "FolderContents"
        FolderContents.AutomaticSize = Enum.AutomaticSize.Y
        FolderContents.Size = UDim2.new(1, 0, 0, 0)
        FolderContents.BorderColor3 = Color3.fromRGB(0, 0, 0)
        FolderContents.Position = UDim2.new(0, 0, 0, 25)
        FolderContents.BorderSizePixel = 0
        FolderContents.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        FolderContents.Parent = Folder

        local FolderContentsPadding = Instance.new("UIPadding")
        FolderContentsPadding.Name = "FolderContentsPadding"
        FolderContentsPadding.PaddingLeft = UDim.new(0, 10)
        FolderContentsPadding.Parent = FolderContents

        local FolderContentsList = Instance.new("UIListLayout")
        FolderContentsList.Name = "FolderContentsList"
        FolderContentsList.SortOrder = Enum.SortOrder.LayoutOrder
        FolderContentsList.Parent = FolderContents

        local FolderText = Instance.new("TextLabel")
        FolderText.Name = "FolderText"
        FolderText.Size = UDim2.new(1, -20, 0, 25)
        FolderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        FolderText.BackgroundTransparency = 1
        FolderText.Position = UDim2.new(0, 20, 0, 0)
        FolderText.BorderSizePixel = 0
        FolderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FolderText.FontSize = Enum.FontSize.Size12
        FolderText.TextSize = 12
        FolderText.TextColor3 = Color3.fromRGB(255, 255, 255)
        FolderText.Text = Options.Name
        FolderText.Font = Enum.Font.Gotham
        FolderText.TextTransparency = 0.2
        FolderText.TextXAlignment = Enum.TextXAlignment.Left
        FolderText.Parent = Folder

        local FolderTextPadding = Instance.new("UIPadding")
        FolderTextPadding.Name = "FolderTextPadding"
        FolderTextPadding.PaddingRight = UDim.new(0, 10)
        FolderTextPadding.Parent = FolderText

        FolderDock.InputBegan:Connect(
            function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if FolderDockImage.Rotation == 0 then
                        Scarlet:MakeTween(
                            {FolderDockImage, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Rotation = 180}}
                        )
                        Scarlet:MakeTween(
                            {
                                Folder,
                                0.15,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                {
                                    Size = UDim2.new(
                                        1,
                                        0,
                                        0,
                                        Folder.AbsoluteSize.Y + Scarlet:GetContentsSize(FolderContents)
                                    )
                                }
                            }
                        )
                    elseif FolderDockImage.Rotation == 180 then
                        Scarlet:MakeTween(
                            {FolderDockImage, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {Rotation = 0}}
                        )
                        Scarlet:MakeTween(
                            {
                                Folder,
                                0.15,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                {Size = UDim2.new(1, 0, 0, 25)}
                            }
                        )
                    end
                end
            end
        )

        FolderContents:GetPropertyChangedSignal("AbsoluteSize"):Connect(
            function()
                if FolderDockImage.Rotation == 180 then
                    Scarlet:MakeTween(
                        {
                            Folder,
                            0.15 / 2,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Size = UDim2.new(1, 0, 0, 25 + FolderContents.AbsoluteSize.Y)}
                        }
                    )
                end
            end
        )

        Folder:GetPropertyChangedSignal("AbsoluteSize"):Connect(
            function()
                if WindowHeaderDockImage.Rotation == 180 then
                    Scarlet:MakeTween(
                        {
                            Window,
                            0.15 / 2,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Size = UDim2.new(0, 250, 0, (35 * 2) + Scarlet:GetContentsSize(WindowContents))}
                        }
                    )
                end
            end
        )

        FolderF.Parent = FolderContents

        return FolderF
    end

    WindowF.Button = function(self, Options, Parent)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Button"
        Options.Callback = Options.Callback or function()
            end

        local Button = Instance.new("Frame")
        Button.Name = "Button"
        Button.Size = UDim2.new(1, 0, 0, 25)
        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button.BorderSizePixel = 0
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Button.BackgroundTransparency = Parent ~= WindowContents and 1 or 0
        Button.Parent = Parent

        local ButtonPadding = Instance.new("UIPadding")
        ButtonPadding.Name = "ButtonPadding"
        ButtonPadding.PaddingLeft = UDim.new(0, 10)
        ButtonPadding.PaddingRight = UDim.new(0, 10)
        ButtonPadding.Parent = Button

        local ButtonText = Instance.new("TextLabel")
        ButtonText.Name = "ButtonText"
        ButtonText.AnchorPoint = Vector2.new(0, 0.5)
        ButtonText.Size = UDim2.new(1, -20, 0, 25)
        ButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ButtonText.BackgroundTransparency = 1
        ButtonText.Position = UDim2.new(0, 20, 0.5, 0)
        ButtonText.BorderSizePixel = 0
        ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonText.FontSize = Enum.FontSize.Size12
        ButtonText.TextSize = 12
        ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonText.Text = Options.Name
        ButtonText.Font = Enum.Font.Gotham
        ButtonText.TextTransparency = 0.2
        ButtonText.TextXAlignment = Enum.TextXAlignment.Left
        ButtonText.Parent = Button

        local ButtonPadding1 = Instance.new("UIPadding")
        ButtonPadding1.Name = "ButtonPadding"
        ButtonPadding1.PaddingRight = UDim.new(0, 10)
        ButtonPadding1.Parent = ButtonText

        local ButtonImage = Instance.new("ImageLabel")
        ButtonImage.Name = "ButtonImage"
        ButtonImage.AnchorPoint = Vector2.new(0, 0.5)
        ButtonImage.Size = UDim2.new(0, 15, 0, 15)
        ButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ButtonImage.BackgroundTransparency = 1
        ButtonImage.Position = UDim2.new(0, 0, 0.5, 0)
        ButtonImage.BorderSizePixel = 0
        ButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
        ButtonImage.Image = "rbxassetid://11295276392"
        ButtonImage.Parent = Button

        Button.InputBegan:Connect(
            function(Input, gameProc)
                if gameProc then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Options.Callback(Options.Name)
                    WindowF:Ripple({Object = Button, Power = 2})
                end
            end
        )
    end

    WindowF.Textfield = function(self, Options)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Textfield"
        Options.Paragraph = Options.Paragraph or "Text"

        local Textfield = Instance.new("Frame")
        Textfield.Name = "Textfield"
        Textfield.AutomaticSize = Enum.AutomaticSize.Y
        Textfield.Size = UDim2.new(1, 0, 0, 40)
        Textfield.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Textfield.BorderSizePixel = 0
        Textfield.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Textfield.BackgroundTransparency = Parent ~= WindowContents and 1 or 0
        Textfield.Parent = Parent

        local Header = Instance.new("Frame")
        Header.Name = "Header"
        Header.AnchorPoint = Vector2.new(0.5, 0)
        Header.Size = UDim2.new(1, 0, 0, 25)
        Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Header.BackgroundTransparency = 1
        Header.Position = UDim2.new(0.5, 0, 0, 0)
        Header.BorderSizePixel = 0
        Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Header.Parent = Textfield

        local TextfieldHeaderImage = Instance.new("ImageLabel")
        TextfieldHeaderImage.Name = "TextfieldHeaderImage"
        TextfieldHeaderImage.AnchorPoint = Vector2.new(0, 0.5)
        TextfieldHeaderImage.Size = UDim2.new(0, 15, 0, 15)
        TextfieldHeaderImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextfieldHeaderImage.BackgroundTransparency = 1
        TextfieldHeaderImage.Position = UDim2.new(0, 0, 0.5, 0)
        TextfieldHeaderImage.BorderSizePixel = 0
        TextfieldHeaderImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextfieldHeaderImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
        TextfieldHeaderImage.Image = "rbxassetid://11963366160"
        TextfieldHeaderImage.Parent = Header

        local TextfieldHeaderText = Instance.new("TextLabel")
        TextfieldHeaderText.Name = "TextfieldHeaderText"
        TextfieldHeaderText.AnchorPoint = Vector2.new(0, 0.5)
        TextfieldHeaderText.Size = UDim2.new(1, -20, 0, 25)
        TextfieldHeaderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextfieldHeaderText.BackgroundTransparency = 1
        TextfieldHeaderText.Position = UDim2.new(0, 20, 0.5, 0)
        TextfieldHeaderText.BorderSizePixel = 0
        TextfieldHeaderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextfieldHeaderText.FontSize = Enum.FontSize.Size12
        TextfieldHeaderText.TextSize = 12
        TextfieldHeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextfieldHeaderText.Text = Options.Name
        TextfieldHeaderText.Font = Enum.Font.Gotham
        TextfieldHeaderText.TextTransparency = 0.2
        TextfieldHeaderText.TextXAlignment = Enum.TextXAlignment.Left
        TextfieldHeaderText.Parent = Header

        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingRight = UDim.new(0, 10)
        UIPadding.Parent = TextfieldHeaderText

        local TextfieldHeaderPadding = Instance.new("UIPadding")
        TextfieldHeaderPadding.Name = "TextfieldHeaderPadding"
        TextfieldHeaderPadding.PaddingLeft = UDim.new(0, 10)
        TextfieldHeaderPadding.PaddingRight = UDim.new(0, 10)
        TextfieldHeaderPadding.Parent = Header

        local TextfieldParagraph = Instance.new("TextLabel")
        TextfieldParagraph.Name = "TextfieldParagraph"
        TextfieldParagraph.AnchorPoint = Vector2.new(0.5, 0)
        TextfieldParagraph.AutomaticSize = Enum.AutomaticSize.Y
        TextfieldParagraph.Size = UDim2.new(1, 0, 0, 20)
        TextfieldParagraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextfieldParagraph.BackgroundTransparency = 1
        TextfieldParagraph.Position = UDim2.new(0.5, 0, 0, 25)
        TextfieldParagraph.BorderSizePixel = 0
        TextfieldParagraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextfieldParagraph.FontSize = Enum.FontSize.Size12
        TextfieldParagraph.TextSize = 12
        TextfieldParagraph.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextfieldParagraph.Text = Options.Paragraph
        TextfieldParagraph.Font = Enum.Font.Gotham
        TextfieldParagraph.TextTransparency = 0.5
        TextfieldParagraph.TextXAlignment = Enum.TextXAlignment.Left
        TextfieldParagraph.Parent = Textfield

        local TextfieldParagraphPadding = Instance.new("UIPadding")
        TextfieldParagraphPadding.Name = "TextfieldParagraphPadding"
        TextfieldParagraphPadding.PaddingBottom = UDim.new(0, 5)
        TextfieldParagraphPadding.PaddingLeft = UDim.new(0, 10)
        TextfieldParagraphPadding.PaddingRight = UDim.new(0, 10)
        TextfieldParagraphPadding.Parent = TextfieldParagraph

        Textfield.Size = UDim2.new(1, 0, 0, Textfield.AbsoluteSize.Y)
    end

    WindowF.Toggle = function(self, Options)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Toggle"
        Options.Default = Options.Default or false
        Options.Callback = Options.Callback or function()
            end

        local Toggle = Instance.new("Frame")
        Toggle.Name = "Toggle"
        Toggle.Size = UDim2.new(1, 0, 0, 25)
        Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.BorderSizePixel = 0
        Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Toggle.BackgroundTransparency = Parent ~= WindowContents and 1 or 0
        Toggle.Parent = Parent

        local TogglePadding = Instance.new("UIPadding")
        TogglePadding.Name = "TogglePadding"
        TogglePadding.PaddingLeft = UDim.new(0, 10)
        TogglePadding.PaddingRight = UDim.new(0, 10)
        TogglePadding.Parent = Toggle

        local ToggleText = Instance.new("TextLabel")
        ToggleText.Name = "ToggleText"
        ToggleText.AnchorPoint = Vector2.new(0, 0.5)
        ToggleText.Size = UDim2.new(1, -20, 0, 25)
        ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ToggleText.BackgroundTransparency = 1
        ToggleText.Position = UDim2.new(0, 20, 0.5, 0)
        ToggleText.BorderSizePixel = 0
        ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleText.FontSize = Enum.FontSize.Size12
        ToggleText.TextSize = 12
        ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleText.Text = Options.Name
        ToggleText.Font = Enum.Font.Gotham
        ToggleText.TextTransparency = 0.2
        ToggleText.TextXAlignment = Enum.TextXAlignment.Left
        ToggleText.Parent = Toggle

        local ToggleTextPadding = Instance.new("UIPadding")
        ToggleTextPadding.Name = "ToggleTextPadding"
        ToggleTextPadding.PaddingRight = UDim.new(0, 10)
        ToggleTextPadding.Parent = ToggleText

        local On = Instance.new("ImageLabel")
        On.Name = "On"
        On.AnchorPoint = Vector2.new(0, 0.5)
        On.Size = UDim2.new(0, 15, 0, 15)
        On.BorderColor3 = Color3.fromRGB(0, 0, 0)
        On.BackgroundTransparency = 1
        On.Position = UDim2.new(0, 0, 0.5, 0)
        On.BorderSizePixel = 0
        On.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        On.ImageTransparency = 1
        On.ImageColor3 = Color3.fromRGB(255, 45, 45)
        On.Image = "rbxassetid://14187538370"
        On.Parent = Toggle

        local Off = Instance.new("ImageLabel")
        Off.Name = "Off"
        Off.AnchorPoint = Vector2.new(0, 0.5)
        Off.Size = UDim2.new(0, 15, 0, 15)
        Off.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Off.BackgroundTransparency = 1
        Off.Position = UDim2.new(0, 0, 0.5, 0)
        Off.BorderSizePixel = 0
        Off.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Off.Image = "rbxassetid://14187539043"
        Off.Parent = Toggle

        Toggle.InputBegan:Connect(
            function(Input, gameProc)
                if gameProc then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Off.ImageTransparency == 0 then
                        Scarlet:MakeTween(
                            {Off, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 1}}
                        )
                        Scarlet:MakeTween(
                            {On, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 0}}
                        )
                        Options.Callback(true)
                    elseif Off.ImageTransparency == 1 then
                        Scarlet:MakeTween(
                            {Off, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 0}}
                        )
                        Scarlet:MakeTween(
                            {On, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 1}}
                        )
                        Options.Callback(false)
                    end

                    WindowF:Ripple({Object = Toggle, Power = 2})
                end
            end
        )

        if Options.Default then
            Options.Callback(true)
            Scarlet:MakeTween({Off, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 1}})
            Scarlet:MakeTween({On, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {ImageTransparency = 0}})
        end
    end

    WindowF.Slider = function(self, Options)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Slider"
        Options.Minimum = Options.Minimum or 0
        Options.Maximum = Options.Maximum or 100
        Options.Default = Options.Default or 0
        Options.Callback = Options.Callback or function()
            end

        local Slider = Instance.new("Frame")
        Slider.Name = "Slider"
        Slider.Size = UDim2.new(1, 0, 0, 40)
        Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Slider.BorderSizePixel = 0
        Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Slider.BackgroundTransparency = Parent ~= WindowContents and 1 or 0
        Slider.Parent = Parent

        local SliderHead = Instance.new("Frame")
        SliderHead.Name = "SliderHead"
        SliderHead.Size = UDim2.new(1, 0, 0, 25)
        SliderHead.BorderColor3 = Color3.fromRGB(255, 255, 255)
        SliderHead.BackgroundTransparency = 1
        SliderHead.BorderSizePixel = 0
        SliderHead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderHead.Parent = Slider

        local SliderHeadImage = Instance.new("ImageLabel")
        SliderHeadImage.Name = "SliderHeadImage"
        SliderHeadImage.AnchorPoint = Vector2.new(0, 0.5)
        SliderHeadImage.Size = UDim2.new(0, 15, 0, 15)
        SliderHeadImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderHeadImage.BackgroundTransparency = 1
        SliderHeadImage.Position = UDim2.new(0, 0, 0.5, 0)
        SliderHeadImage.BorderSizePixel = 0
        SliderHeadImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderHeadImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
        SliderHeadImage.Image = "rbxassetid://11295283482"
        SliderHeadImage.Parent = SliderHead

        local SliderHeadPadding = Instance.new("UIPadding")
        SliderHeadPadding.Name = "SliderHeadPadding"
        SliderHeadPadding.PaddingTop = UDim.new(0, 5)
        SliderHeadPadding.PaddingLeft = UDim.new(0, 10)
        SliderHeadPadding.PaddingRight = UDim.new(0, 10)
        SliderHeadPadding.Parent = SliderHead

        local SliderHeadText = Instance.new("TextLabel")
        SliderHeadText.Name = "SliderHeadText"
        SliderHeadText.AnchorPoint = Vector2.new(0, 0.5)
        SliderHeadText.Size = UDim2.new(1, -20, 0, 25)
        SliderHeadText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderHeadText.BackgroundTransparency = 1
        SliderHeadText.Position = UDim2.new(0, 20, 0.5, 0)
        SliderHeadText.BorderSizePixel = 0
        SliderHeadText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderHeadText.FontSize = Enum.FontSize.Size12
        SliderHeadText.TextSize = 12
        SliderHeadText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderHeadText.Text = "Slider"
        SliderHeadText.Font = Enum.Font.Gotham
        SliderHeadText.TextTransparency = 0.2
        SliderHeadText.TextXAlignment = Enum.TextXAlignment.Left
        SliderHeadText.Parent = SliderHead

        local SliderHeadTextPadding = Instance.new("UIPadding")
        SliderHeadTextPadding.Name = "SliderHeadTextPadding"
        SliderHeadTextPadding.PaddingRight = UDim.new(0, 10)
        SliderHeadTextPadding.Parent = SliderHeadText

        local SliderHeadInput = Instance.new("TextBox")
        SliderHeadInput.Name = "SliderHeadInput"
        SliderHeadInput.AnchorPoint = Vector2.new(1, 0.5)
        SliderHeadInput.Size = UDim2.new(0, 20, 1, 0)
        SliderHeadInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderHeadInput.BackgroundTransparency = 1
        SliderHeadInput.Position = UDim2.new(1, 0, 0.5, 0)
        SliderHeadInput.BorderSizePixel = 0
        SliderHeadInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderHeadInput.FontSize = Enum.FontSize.Size12
        SliderHeadInput.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
        SliderHeadInput.TextSize = 12
        SliderHeadInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderHeadInput.PlaceholderText = "..."
        SliderHeadInput.Text = "0"
        SliderHeadInput.Font = Enum.Font.Gotham
        SliderHeadInput.Parent = SliderHead

        local SliderBottom = Instance.new("Frame")
        SliderBottom.Name = "SliderBottom"
        SliderBottom.AnchorPoint = Vector2.new(0.5, 1)
        SliderBottom.Size = UDim2.new(1, -8, 0, 15)
        SliderBottom.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderBottom.BackgroundTransparency = 1
        SliderBottom.Position = UDim2.new(0.5, 0, 1, 0)
        SliderBottom.BorderSizePixel = 0
        SliderBottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderBottom.Parent = Slider

        local SliderBottomUIPadding = Instance.new("UIPadding")
        SliderBottomUIPadding.Name = "SliderBottomUIPadding"
        SliderBottomUIPadding.PaddingLeft = UDim.new(0, 10)
        SliderBottomUIPadding.PaddingRight = UDim.new(0, 10)
        SliderBottomUIPadding.Parent = SliderBottom

        local SliderBottomIn = Instance.new("Frame")
        SliderBottomIn.Name = "SliderBottomIn"
        SliderBottomIn.Size = UDim2.new(1, 0, 0, 3)

        SliderBottomIn.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderBottomIn.Position = UDim2.new(0, 0, 0, 6)
        SliderBottomIn.BorderSizePixel = 0
        SliderBottomIn.BackgroundColor3 = Color3.fromRGB(185, 185, 185)
        SliderBottomIn.Parent = SliderBottom

        local SliderBottomInOut = Instance.new("Frame")
        SliderBottomInOut.Name = "SliderBottomInOut"
        SliderBottomInOut.Size =
            UDim2.new(
            ((Options.Default or Options.Minimum) - Options.Minimum) / (Options.Maximum - Options.Minimum),
            0,
            1,
            0
        )

        SliderBottomInOut.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderBottomInOut.BorderSizePixel = 0
        SliderBottomInOut.BackgroundColor3 = Color3.fromRGB(255, 45, 45)
        SliderBottomInOut.Parent = SliderBottomIn

        local SliderBottomInOutCorner = Instance.new("UICorner")
        SliderBottomInOutCorner.Name = "SliderBottomInOutCorner"
        SliderBottomInOutCorner.CornerRadius = UDim.new(1, 0)
        SliderBottomInOutCorner.Parent = SliderBottomInOut

        local SliderBottomInOutCircle = Instance.new("Frame")
        SliderBottomInOutCircle.Name = "SliderBottomInOutCircle"
        SliderBottomInOutCircle.ZIndex = 2
        SliderBottomInOutCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        SliderBottomInOutCircle.Size = UDim2.new(0, 8, 0, 8)
        SliderBottomInOutCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderBottomInOutCircle.Position = UDim2.new(1, 0, 0.5, 0)
        SliderBottomInOutCircle.BorderSizePixel = 0
        SliderBottomInOutCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderBottomInOutCircle.Parent = SliderBottomInOut

        local SliderBottomInOutCircleCorner = Instance.new("UICorner")
        SliderBottomInOutCircleCorner.Name = "SliderBottomInOutCircleCorner"
        SliderBottomInOutCircleCorner.CornerRadius = UDim.new(1, 0)
        SliderBottomInOutCircleCorner.Parent = SliderBottomInOutCircle

        local SliderBottomInOutCircleFadeCircle = Instance.new("Frame")
        SliderBottomInOutCircleFadeCircle.Name = "SliderBottomInOutCircleFadeCircle"
        SliderBottomInOutCircleFadeCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        SliderBottomInOutCircleFadeCircle.Size = UDim2.new(1, 8, 1, 8)
        SliderBottomInOutCircleFadeCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SliderBottomInOutCircleFadeCircle.BackgroundTransparency = 1
        SliderBottomInOutCircleFadeCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
        SliderBottomInOutCircleFadeCircle.BorderSizePixel = 0
        SliderBottomInOutCircleFadeCircle.BackgroundColor3 = Color3.fromRGB(255, 45, 45)
        SliderBottomInOutCircleFadeCircle.Parent = SliderBottomInOutCircle

        local SliderBottomInOutCircleFadeCircleCorner = Instance.new("UICorner")
        SliderBottomInOutCircleFadeCircleCorner.Name = "SliderBottomInOutCircleFadeCircleCorner"
        SliderBottomInOutCircleFadeCircleCorner.CornerRadius = UDim.new(1, 0)
        SliderBottomInOutCircleFadeCircleCorner.Parent = SliderBottomInOutCircleFadeCircle

        local isSliderDragging = false

        local function Slide()
            local XSize = (Scarlet.Mouse.X - SliderBottomIn.AbsolutePosition.X) / SliderBottomIn.AbsoluteSize.X
            XSize = math.clamp(XSize, 0, 1)

            Scarlet:MakeTween(
                {
                    SliderBottomInOut,
                    0.15,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    {Size = UDim2.new(XSize, 0, 1, 0)}
                }
            )

            local Dec2 =
                (((XSize * Options.Maximum) / Options.Maximum) * (Options.Maximum - Options.Minimum) + Options.Minimum) *
                100

            Dec2 = math.floor(Dec2)
            SliderHeadInput.Text = Dec2 / 100
            Options.Callback(tonumber(SliderHeadInput.Text))
        end

        SliderHeadInput.FocusLost:Connect(
            function()
                if tonumber(SliderHeadInput.Text) then
                    SliderHeadInput.Text =
                        math.floor(math.clamp(tonumber(SliderHeadInput.Text), Options.Minimum, Options.Maximum) * 100) /
                        100
                else
                    SliderHeadInput.Text = tonumber(Options.Default)
                end

                Scarlet:MakeTween(
                    {
                        SliderBottomInOut,
                        0.15,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {
                            Size = UDim2.new(
                                ((tonumber(SliderHeadInput.Text) or Options.Minimum) - Options.Minimum) /
                                    (Options.Maximum - Options.Minimum),
                                0,
                                1,
                                0
                            )
                        }
                    }
                )

                Options.Callback(tonumber(SliderHeadInput.Text))
            end
        )

        SliderBottom.InputBegan:Connect(
            function(Input, gameProc)
                if gameProc then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isSliderDragging = true

                    Slide()
                    Scarlet:MakeTween(
                        {
                            SliderBottomInOutCircleFadeCircle,
                            0.25,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {BackgroundTransparency = 0.5}
                        }
                    )
                end
            end
        )

        SliderBottom.InputEnded:Connect(
            function(Input, gameProc)
                if gameProc then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isSliderDragging = false

                    Scarlet:MakeTween(
                        {
                            SliderBottomInOutCircleFadeCircle,
                            0.25,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {BackgroundTransparency = 1}
                        }
                    )
                end
            end
        )

        Scarlet.Mouse.Move:Connect(
            function()
                local X, Y = Scarlet.Mouse.X, Scarlet.Mouse.Y

                if isSliderDragging then
                    Slide()
                end
            end
        )

        Options.Callback(Options.Default)
    end

    WindowF.Inputfield = function(self, Options)
        local Options = Options or {}
        local Parent = self.Parent or WindowContents

        Options.Name = Options.Name or "Inputfield"
        Options.Default = Options.Default or false
        Options.Callback = Options.Callback or function()
            end

        local Inputfield = Instance.new("Frame")
        Inputfield.Name = "Inputfield"
        Inputfield.Size = UDim2.new(1, 0, 0, 25)
        Inputfield.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Inputfield.BorderSizePixel = 0
        Inputfield.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Inputfield.BackgroundTransparency = Parent ~= WindowContents and 1 or 0
        Inputfield.Parent = Parent

        local InputfieldPadding = Instance.new("UIPadding")
        InputfieldPadding.Name = "InputfieldPadding"
        InputfieldPadding.PaddingLeft = UDim.new(0, 10)
        InputfieldPadding.PaddingRight = UDim.new(0, 10)
        InputfieldPadding.Parent = Inputfield

        local InputfieldText = Instance.new("TextLabel")
        InputfieldText.Name = "InputfieldText"
        InputfieldText.AnchorPoint = Vector2.new(0, 0.5)
        InputfieldText.Size = UDim2.new(1, -20, 0, 25)
        InputfieldText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputfieldText.BackgroundTransparency = 1
        InputfieldText.Position = UDim2.new(0, 20, 0.5, 0)
        InputfieldText.BorderSizePixel = 0
        InputfieldText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldText.FontSize = Enum.FontSize.Size12
        InputfieldText.TextSize = 12
        InputfieldText.TextColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldText.Text = "Inputfield"
        InputfieldText.Font = Enum.Font.Gotham
        InputfieldText.TextTransparency = 0.2
        InputfieldText.TextXAlignment = Enum.TextXAlignment.Left
        InputfieldText.Parent = Inputfield

        local InputfieldTextPadding = Instance.new("UIPadding")
        InputfieldTextPadding.Name = "InputfieldTextPadding"
        InputfieldTextPadding.PaddingRight = UDim.new(0, 10)
        InputfieldTextPadding.Parent = InputfieldText

        local InputfieldImage = Instance.new("ImageLabel")
        InputfieldImage.Name = "InputfieldImage"
        InputfieldImage.AnchorPoint = Vector2.new(0, 0.5)
        InputfieldImage.Size = UDim2.new(0, 15, 0, 15)
        InputfieldImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputfieldImage.BackgroundTransparency = 1
        InputfieldImage.Position = UDim2.new(0, 0, 0.5, 0)
        InputfieldImage.BorderSizePixel = 0
        InputfieldImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldImage.ImageColor3 = Color3.fromRGB(255, 45, 45)
        InputfieldImage.Image = "rbxassetid://11295278585"
        InputfieldImage.Parent = Inputfield

        local InputfieldInput = Instance.new("TextBox")
        InputfieldInput.Name = "InputfieldInput"
        InputfieldInput.AnchorPoint = Vector2.new(1, 0.5)
        InputfieldInput.Size = UDim2.new(0, 20, 1, 0)
        InputfieldInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputfieldInput.BackgroundTransparency = 1
        InputfieldInput.Position = UDim2.new(1, 0, 0.5, 0)
        InputfieldInput.BorderSizePixel = 0
        InputfieldInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldInput.FontSize = Enum.FontSize.Size12
        InputfieldInput.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldInput.TextSize = 12
        InputfieldInput.TextTransparency = 0.5
        InputfieldInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        InputfieldInput.PlaceholderText = "..."
        InputfieldInput.Text = ""
        InputfieldInput.Font = Enum.Font.Gotham
        InputfieldInput.ClearTextOnFocus = true
        InputfieldInput.Parent = Inputfield

        InputfieldInput.FocusLost:Connect(
            function()
                Options.Callback(InputfieldInput.Text)
            end
        )

        if Options.Default then
            InputfieldInput.Text = Options.Default
            Options.Callback(Options.Default)
        end
    end

    return WindowF
end

return Scarlet
