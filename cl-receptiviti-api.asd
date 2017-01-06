;;;; cl-receptiviti-api.asd

(asdf:defsystem #:cl-receptiviti-api
  :description "API bindings for the Receptiviti API. <https://app.receptiviti.com/v2/api/spec>"
  :author "inaimathi <leo.zovic@gmail.com>"
  :license "Expat"
  :depends-on (#:alexandria #:drakma #:yason)
  :serial t
  :components ((:file "package")
               (:file "cl-receptiviti-api")))
