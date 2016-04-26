(import time
        [subprocess [call]]
        [os [getcwd]])

(def handle
  {:time (.time time)
   :pb nil
   :config nil
   :commands {"send dog" 1
              "send cat" 2
              "still working?" 3}})

;; pb.get_pushes grabs all pushes since a specified time
;; After every .get_pushes, the handle time needs to be updated
(defn init-handler [pb config]
  (assoc handle :pb pb)
  (assoc handle :config config)
  (assoc handle :time (.time time)))

(defn update-time []
  (assoc handle :time (.time time)))

(defn who? [push]
  (-> push
    (.get "sender_name")
    (.split " ")
    (first)))

(defn responder [cam-id push]
  ;;(print (format "Responding key: {}" (str cam-id)))
  (if (= 3 cam-id)
    (.push_note (:pb handle) "" (.format
                                  "Hey {}!, Yes I'm still working"
                                  (who? push)))
    (do
      (.push_note (:pb handle) "" "Got it!")
      (call [(.format "{}/cam.py {}" (:base-dir (:config handle)) cam-id)] :shell True)
      (with [[pic (open (.format "{}/picdump/picout.png" (:base-dir (:config handle))) "rb")]]
        (let [[data (.upload_file (:pb handle) pic "Here's your pic!")]]
          (.push_file (:pb handle) :file_name (.get data "file_name")
                                   :file_url  (.get data "file_url")
                                   :file_type (.get data "file_type")))))))

(defn commander [command push]
  (if (in command (:commands handle))
    (do
      (.delete_push (:pb handle) (.get push "iden"))
      (responder (.get (:commands handle) command) push))))

(defn dispatch [push]
  (if push
    (let [[pb (:pb handle)]]
      (-> push
        (.get "body" "")
        (.strip)
        (.lower)
        ((fn [p] (if p (commander p push))))))))

(defn valid-sender? [sender]
  (in sender (:users (:config handle))))

(defn handler [data]
  ;;(print data)
  (let [[push (first (.get_pushes (:pb handle) (:time handle)))]]
    (if push
      (do
        (update-time)
        (cond [(.get push "dismissed") nil]
              [(not (.get push "active")) nil]
              [(valid-sender? (.get push "sender_name" )) (dispatch push)])))))

