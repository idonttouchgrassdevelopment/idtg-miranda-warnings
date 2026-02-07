// Global variables for configuration
let mirandaRights = [];
let uiSettings = {};

// Listen for messages from the game client
window.addEventListener('message', function(event) {
    var item = event.data;
    
    // Handle UI visibility
    if (item.type === "ui") {
        if (item.status) {
            // Store config data
            if (item.config) {
                mirandaRights = item.config.rights;
                uiSettings = item.config.uiSettings;
                
                // Update UI with config data
                updateUIFromConfig();
            }
            
            // Show the UI
            document.getElementById("miranda-card").classList.add('visible');
            console.log('[Miranda Rights] UI shown');
        } else {
            // Hide the UI
            document.getElementById("miranda-card").classList.remove('visible');
            console.log('[Miranda Rights] UI hidden');
        }
    }
});

// Update UI elements based on config
function updateUIFromConfig() {
    // Update title
    if (uiSettings.Title) {
        document.getElementById("card-title").textContent = uiSettings.Title;
    }
    
    // Update rights text
    const rightsTextContainer = document.getElementById("rights-text");
    rightsTextContainer.innerHTML = ''; // Clear existing content
    
    // Add each right as a paragraph
    mirandaRights.forEach((right, index) => {
        const paragraph = document.createElement('p');
        paragraph.textContent = `${index + 1}. ${right}`;
        rightsTextContainer.appendChild(paragraph);
    });
}

// Force close UI as a fallback mechanism
function forceCloseUI() {
    console.log('[Miranda Rights] Force closing UI');
    document.getElementById("miranda-card").classList.remove('visible');
}

// Double-click on card background to force close (emergency backup)
document.getElementById("miranda-card").addEventListener('dblclick', function(e) {
    // Only close if clicking outside the card content
    if (e.target === document.getElementById("miranda-card")) {
        console.log('[Miranda Rights] Double-click force close');
        forceCloseUI();
    }
});

// Prevent form submission
document.addEventListener('submit', function(event) {
    event.preventDefault();
});