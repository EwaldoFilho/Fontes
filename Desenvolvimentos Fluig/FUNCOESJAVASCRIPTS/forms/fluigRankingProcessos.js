const ds = DatasetFactory.getDataset('workflowProcess', null, null, null);

const outObject = ds.values.reduce(function(a, e) {
  let estKey = (e['processId']);

  (a[estKey] ? a[estKey] : (a[estKey] = null || [])).push(e);
  return a;
}, {});

console.log(outObject);