;;;; cl-receptiviti-api.lisp

(in-package #:cl-receptiviti-api)

(defun hash (&rest k/v-pairs)
  (let ((h (make-hash-table :test 'equal)))
    (loop for (k v) on k/v-pairs by #'cddr
       do (setf (gethash k h) v))
    h))

(defun json (thing)
  (with-output-to-string (s)
    (yason:encode thing s)))

(defun v2 (endpoint &key (method :get) (api-key *api-key*) (api-secret *api-secret*) (content-type "application/json") params)
  (let ((res (drakma:http-request
	      (format nil "~a/v2/api/~a" *server* endpoint)
	      :additional-headers
	      `(("X-API-KEY" . ,api-key) ("X-API-SECRET-KEY" . ,api-secret))
	      :method method
	      :content-type (when (and (eq :post method) params) content-type)
	      :parameters (when (and (eq :get method) params)
			    (alexandria:hash-table-alist params))
	      :content (when (and (eq :post method) params) params))))
    (map 'string #'code-char res)))

(defun get-persons ()
  (yason:parse (v2 "person") :object-as :alist))

(defun create-person (name &key (handle (format nil "user:~a" name)) (gender :dunno))
  (let ((ps (hash
	       "name" name
	       "person_handle" handle
	       "gender" (position gender #(:dunno :male :female)))))
    (format t "~s~%" (alexandria:hash-table-alist ps))
    (v2 "person" :method :post :params (json ps))))
