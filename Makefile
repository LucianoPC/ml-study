.PHONY: all clean


IRIS_URL = "http://api.salic.cultura.gov.br/v1/fornecedores/?format=csv"


all: data/raw/fornecedores.csv

clean:
	rm -f data/raw/*.csv

data/raw/fornecedores.csv:
	python src/data/download.py $(IRIS_URL) $@
