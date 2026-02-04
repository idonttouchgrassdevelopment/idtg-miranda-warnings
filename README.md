# Miranda Rights Card UI for FiveM

A simple and elegant Miranda Rights card UI for FiveM roleplay servers. This resource allows law enforcement officers to display Miranda Rights to suspects during roleplay scenarios, with an acknowledgment system.

## Features

- Clean, professional-looking Miranda Rights card UI
- Toggle the card with a command or keybind
- "I Understand" button for suspect acknowledgment
- Fully configurable rights text and UI settings
- Easy to customize and integrate with other scripts

## Installation

1. Download the resource
2. Place the `miranda-rights-card` folder in your server's resources directory
3. Add `ensure miranda-rights-card` to your server.cfg
4. Restart your server or start the resource manually

## Usage

### In-Game Commands

- `/miranda` - Toggle the Miranda Rights card (configurable in config.lua)
- Default keybind: `F9` (configurable in config.lua)

### UI Controls

- **I Understand Button**: Announces in chat that the suspect has acknowledged their rights
- **Close Button**: Closes the Miranda Rights card
- **ESC Key**: Also closes the card

## Configuration

### Customizing the Miranda Rights Text

You can easily customize the Miranda Rights text by editing the `config.lua` file:

```lua
Config = {}

-- Miranda Rights text configuration
-- Each line will be displayed as a separate paragraph
Config.MirandaRights = {
    "You have the right to remain silent.",
    "Anything you say can and will be used against you in a court of law.",
    "You have the right to an attorney.",
    "If you cannot afford an attorney, one will be provided for you.",
    "Do you understand the rights I have just read to you?",
    "With these rights in mind, do you wish to speak to me?"
}

-- UI Configuration
Config.UISettings = {
    Title = "MIRANDA WARNING",
    AcknowledgeButtonText = "I Understand",
    CloseButtonText = "Close"
}

-- Command Configuration
Config.Command = "miranda"
Config.DefaultKeybind = "F9"
```

### Changing the Appearance

To modify the appearance of the card, edit the `style.css` file in the `ui` folder.

## Integration with Other Scripts

You can integrate this resource with other police/law enforcement scripts by triggering the `miranda` command or by using the following exports:

```lua
-- To show the Miranda Rights card
exports['miranda-rights-card']:showMirandaCard()

-- To hide the Miranda Rights card
exports['miranda-rights-card']:hideMirandaCard()
```