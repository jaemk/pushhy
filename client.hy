(import [settings [config]]
        [handlers]
        [pushbullet [Pushbullet Listener]])

(def pb
  (Pushbullet (:api-key config)))

(def listener
  (Listener :account pb :on_push handlers.handler
            :http_proxy_host nil
            :http_proxy_port nil))

(defn start []
  ;;(print "Starting...")
  (handlers.init-handler pb config)
  (try
    (.run_forever listener)
    (except [Exception KeyboardInterrupt] (print "Exiting"))))

(if (= __name__ "__main__")
  (start))
