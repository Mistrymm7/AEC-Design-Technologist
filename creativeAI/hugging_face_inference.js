// input and labels from function input
// Models that can be used https://huggingface.co/tasks
// Eg sentimentanalysis(input, labels){async calls)



fetch('https://api-inference.huggingface.co/models/facebook/bart-large-mnli',{
     method: 'POST',
     body: JSON.stringify({
      "inputs": "Today is a good day",
    "parameters": {"candidate_labels": ["good","bad", "neutral"]}}),
    headers: {
      "Content-type": "application/json; charset=UTF-8",
      "Authorization": "Bearer " + "PASTE_TOKEN_ID_HERE"
    }
})
  .then(response => response.json())
  .then(data => console.log(data));
