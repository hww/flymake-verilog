;; flymake-mode
(autoload 'flymake-mode "flymake" "flymake-mode for automatic syntax check" t)
;; flymake-mode for Verilog HDL
(add-hook 'verilog-mode-hook (lambda () (flymake-mode 1)))
;; flymake settings
(eval-after-load "flymake"
  '(progn
     ;; Verilog HDL
     (defun flymake-verilog-init ()
       (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
              (local (file-relative-name temp (file-name-directory buffer-file-name))))
         (list "iverilog" (list "-tnull" local))))
     (add-to-list 'flymake-err-line-patterns
                  '("\\(^No.*\\)$" nil nil nil 1))
     (add-to-list 'flymake-err-line-patterns
                  '("\\(.*?\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3))
     (push '("\\.[v]\\'" flymake-verilog-init) flymake-allowed-file-name-masks)))
