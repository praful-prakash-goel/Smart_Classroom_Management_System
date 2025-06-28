# custom_transformers.py
import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin

class outlier_clipper(BaseEstimator, TransformerMixin):
    def __init__(self, cols, lower_quantile=0.01, upper_quantile=0.99):
        self.cols = cols
        self.lower_quantile = lower_quantile
        self.upper_quantile = upper_quantile

    def fit(self, X, y=None):
        self.lower_bounds = {}
        self.upper_bounds = {}
        for col in self.cols:
            self.lower_bounds[col] = X[col].quantile(self.lower_quantile)
            self.upper_bounds[col] = X[col].quantile(self.upper_quantile)
        return self

    def transform(self, X):
        X = X.copy()
        for col in self.cols:
            X[col] = X[col].clip(lower=self.lower_bounds[col], upper=self.upper_bounds[col])
        return X

    def get_feature_names_out(self, input_features=None):
        return np.array(input_features if input_features is not None else self.cols)
