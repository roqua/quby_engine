// This code is necessary for integrating Roqua into the Poli+ epd. 
// If not included, user actions in Roqua might break the epd.

// WARNING :: This code doens't work in Firefox

// Disable all shortKeys
document.onkeydown = function(event) {
    if (event == null){
        event = window.event
    }

    keyCode = (document.layers) ? keyStroke.which : event.keyCode
	target = (event.target) ? event.target : event.srcElement

    if (keyCode != null){
        if ((keyCode >= 112 && keyCode <= 123)   // F1 t/m F12
            || (event.ctrlKey && keyCode == 70) // f (zoeken)
            || (event.ctrlKey && keyCode == 79) // o (openen)
            || (event.ctrlKey && keyCode == 80) // p (printen)
            ) {
            if (window.event) {
                event.keyCode = 505;
            }
            return false;
        }

        if ((keyCode == 8 && 
	        (target.tagName != 'INPUT' || (target.type != 'text' && target.type != 'password')) && 
	        target.tagName != 'TEXTAREA') // Backspace outside input field
            || (event.ctrlKey && keyCode == 65) // a (alles selecteren)
            || (event.ctrlKey && keyCode == 66) // b (favorieten indelen)
            || (event.ctrlKey && keyCode == 68) // d (bookmark)
            || (event.ctrlKey && keyCode == 69) // e (zoeken op het web)
            || (event.ctrlKey && keyCode == 72) // h (geschiedenis)
            || (event.ctrlKey && keyCode == 73) // i (favorieten)
            || (event.ctrlKey && keyCode == 76) // l (openen)
            || (event.ctrlKey && keyCode == 78) // n (nieuw venster)
            || (event.ctrlKey && keyCode == 82) // r (refresh)
            || (event.ctrlKey && keyCode == 87) // w (afsluiten)
            || (event.altKey && keyCode == 37)) // links (back)
        {
            return false;
        }
    }
}
