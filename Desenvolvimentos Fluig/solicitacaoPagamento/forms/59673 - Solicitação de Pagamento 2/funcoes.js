var myTagAutocomplete = FLUIGC.autocomplete('#exampleTagAutocomplete', {
    source: {
        url: 'myrest/list',
        limit: 10,
        offset: 0,
        root: 'content'
    },
    displayKey: 'description',
    tagClass: 'tag-gray',
    type: 'tagAutocomplete'
});