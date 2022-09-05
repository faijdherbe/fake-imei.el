;;; fake-imei.el --- a simple package                     -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Nic Ferrier

;; Author: Jeroen Faijdherbe <jeroen@faijdherbe.net>
;; Keywords: lisp, imei
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package generates fake -but valid- IMEI numbers, including the Check Digit.

;;; Code:

(defun fake-imei ()
    "Generate random (fake, but valid) IMEI number."
    (let* ((input (mapconcat #'identity (loop for i from 0 below 14 collect (number-to-string (random 10))) ""))
       (counter 0)
       (sum (apply '+ (mapcar (lambda (c)
                      (let ((v (if (= (% counter 2) 0)
                          (string-to-number (char-to-string c))
                        (* (string-to-number (char-to-string c)) 2))))
                        (cl-incf counter)

                        (if (> v 9)
                            (+ 1 (- v 10))
                          v)
                        )) input))))
      (concat input (number-to-string (- 10 (% sum 10))))))

(defun insert-fake-imei-at-point ()
  "Insert randomly generated (fake, but valid) IMEI at point."
  (interactive)
  (insert (fake-imei)))

(provide 'fake-imei)
;;; fake-imei.el ends here
