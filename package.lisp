;;;; package.lisp

(defpackage #:cl-receptiviti-api
  (:use #:cl)
  (:export
   #:v2 #:get-persons #:create-person))

(in-package :cl-receptiviti-api)

(defparameter *api-key* (error "Replace this error with your API key"))
(defparameter *api-secret* (error "Replace this error with your API secret key"))

(defparameter *server* "http://app.receptiviti.com")
