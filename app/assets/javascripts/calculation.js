// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

function initAutocomplete() {
    autocomplete = new google.maps.places.Autocomplete(
            (document.getElementById('address')),
            {types: ['(cities)']});
}

