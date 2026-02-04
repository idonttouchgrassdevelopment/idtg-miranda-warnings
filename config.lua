Config = {}

-- Miranda Rights text configuration
-- Each line will be displayed as a separate paragraph
Config.MirandaRights = {
    "You have the right to remain silent.",
    "Anything you say can and will be used against you in a court of law.",
    "You have the right to an attorney present before and during questioning to protect your rights and interests.",
    "If you cannot afford an attorney, one will be provided for you.",
    "Do you understand your rights as I read them to you?",
    "With these rights in mind, do you wish to continue speaking with officers?"
}

-- UI Configuration
Config.UISettings = {
    Title = "MIRANDA WARNING"
}

-- Command Configuration
Config.Command = "miranda"
Config.DefaultKeybind = "F9"

-- Job Restriction Configuration
-- Set to true to enable job restrictions, false to allow everyone
Config.JobRestriction = true

-- List of jobs that can access the Miranda Rights Card
-- Add or remove jobs as needed
Config.AllowedJobs = {
    'police',
    'sheriff',
    'state',
    'fbi',
    'swat'
}