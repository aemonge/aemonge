from sklearn.chatgpt import ChatGPTClassifier, ChatGPTRegresor

X_train, X_test, y_train, y_test = train_test_split(X, y)
clf = ChatGPTClassifier(random_state=42).fit(X_train, y_test)
clf.score(X_test, y_test)
