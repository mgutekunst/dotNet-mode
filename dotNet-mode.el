;;; dotNet-mode.el --- 

;; Copyright 2014 
;;
;; Author: Manuel Gutekunst

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:
;; This is a minor mode that provides some convenience functions to edit and
;; build .NET projects and solutions.
;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'dotNet-mode)

;;; Code:

(eval-when-compile
  (require 'cl))

;; keymap
(defvar dotNet-mode-keymap (make-sparse-keymap) "dotNet-mode keymap")
(define-key dotNet-mode-keymap (kbd "<f6>") 'dnt/run-Mstest)

;;;###autoload
(define-minor-mode dotNet-mode
"dotNet-mode is a minor-mode that tries to help building .NET Applications with emacs."
:group      'dotNet
:init-value nil
:global     nil
:lighter    " .NET"
:keymap dotNet-mode-keymap)

(defcustom dnt/Msbuild-executable-path nil
"Path to the folder where Msbuil.exe resides")

(defcustom dnt/Mstest-executable-path nil
"Path to the folder where Mstest.exe resides")


(defun dnt/run-Mstest (path &optional args)
  "run Mstest.exe on a .dll lead to path"
  (interactive (list (read-file-name "Run Mstest.exe for dll: ")))
  (setq msTest-Buffer "*Test-Results*")
  (when (equal nil dnt/Mstest-executable-path)
    (setq dnt/Mstest-executable-path (executable-find "Mstest")))
  (if (string= (file-name-extension path) "dll")
;; use let or progn here, restore compile-path afterwards
      (compilation-start (concat (shell-quote-argument dnt/Mstest-executable-path) " /testcontainer:"(shell-quote-argument path) " /detail:link /detail:errormessage"))
    (error "%s is not leading to a valid .dll file" path)))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

(provide 'dotNet-mode)

;;; dotNet-mode.el ends here
