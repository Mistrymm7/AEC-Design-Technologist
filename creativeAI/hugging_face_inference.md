* input and labels from function input
* Models that can be used https://huggingface.co/tasks
* Eg sentimentanalysis(input, labels){async calls)


===============
# Labels of sentence (NLP)

```javascript
     
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

```

==============
# Vision Transformer (Computer Vision)

```python 

from transformers import ViTFeatureExtractor, ViTForImageClassification
from PIL import Image
import requests

url = 'http://images.cocodataset.org/val2017/000000039769.jpg'
image = Image.open(requests.get(url, stream=True).raw)

feature_extractor = ViTFeatureExtractor.from_pretrained('google/vit-base-patch16-224')
model = ViTForImageClassification.from_pretrained('google/vit-base-patch16-224')

inputs = feature_extractor(images=image, return_tensors="pt")
outputs = model(**inputs)
logits = outputs.logits

# model predicts one of the 1000 ImageNet classes
predicted_class_idx = logits.argmax(-1).item()
print("Predicted class:", model.config.id2label[predicted_class_idx])
```
