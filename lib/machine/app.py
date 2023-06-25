from flask import Flask, request, jsonify
from sklearn import tree
import pandas as pd
import numpy as np

app = Flask(__name__)


@app.route("/predict/stunting", methods=["POST"])
def predict():
    data = request.json
    input_data = np.array(data["input"])
    prediction = clf.predict([input_data])
    return jsonify({"prediction": prediction[0]})


if __name__ == "__main__":
    stunting_df = pd.read_excel("stunting.xlsx")
    sex = {"jenis_kelamin": {"laki-laki": 0, "perempuan": 1}}
    stunting_df.replace(sex, inplace=True)
    one_hot_data = stunting_df[
        ["jenis_kelamin", "bulan", "berat_badan", "tinggi_badan"]
    ]
    clf = tree.DecisionTreeClassifier()
    clf_train = clf.fit(one_hot_data, stunting_df["stunting"])
    app.run()
