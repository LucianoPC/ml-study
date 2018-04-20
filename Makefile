.PHONY: all test clean

IRIS_URL = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
FORNECEDORES_URL = "http://api.salic.cultura.gov.br/v1/fornecedores/?format=csv"


all: data/processed/processed.pickle reports/figures/exploratory.png

test: all
	pytest src

clean:
	rm -f data/raw/*.csv
	rm -f data/processed/*.pickle
	rm -f data/processed/*.xlsx
	rm -f reports/figures/*.png

data/raw/iris.csv:
	python src/data/download.py $(IRIS_URL) $@

data/raw/fornecedores.csv:
	python src/data/download.py $(FORNECEDORES_URL) $@

data/processed/processed.pickle: data/raw/iris.csv
	python src/data/preprocess.py $< $@ --excel data/processed/processed.xlsx

reports/figures/exploratory.png: data/processed/processed.pickle
	python src/visualization/exploratory.py $< $@
