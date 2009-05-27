// an example map function, emits the doc id 
// and the list of keys it contains
// !code lib.helpers.math

function(doc) {
  emit(null, doc);
};
