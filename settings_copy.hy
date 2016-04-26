(import [os [path]])

;; Your info goes here
;; Note: First user is the main-user
(def config
  {:users ["Firstname Lastname" "Firstname Lastname"]
   :api-key "YourSecretKey"
   :base-dir (path.dirname (path.realpath __file__))})

