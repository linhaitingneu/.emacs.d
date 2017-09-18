;;global setting
(setq package-archives
      '(
        ("elpa" . "http://tromey.com/elpa/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ))
(package-initialize) ;; init elpa packages

(when (getenv "ORG_HOME")
  (let ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME"))))
    (when (file-directory-p org-lisp-dir)
      (add-to-list 'load-path org-lisp-dir)
      (require 'org))))

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(global-linum-mode t)
(setq x-select-enable-clipboard t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq echo-keystrokes 0.1)
(global-font-lock-mode t)
(which-func-mode 1)
(icomplete-mode 1)
(global-hl-line-mode 1)
(setq frame-title-format "%b@emacs")
(show-paren-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(debug-on-error t)
 '(display-time-mode t)
 '(ede-project-directories (quote ("e:/program" "e:/program/c/untitled")))
 '(jdee-compile-option-encoding "UTF-8")
 '(jdee-server-dir "D:\\jdee-server-master")
 '(package-selected-packages
   (quote
    (cmake-mode sr-speedbar helm-gtags java-imports web-beautify thread-dump session org mvn json jdee javascript javap-mode java-snippets guide-key goto-chg ggtags ecb company common-lisp-snippets auto-complete adjust-parens)))
 '(semantic-default-submodes
   (quote
    (global-semantic-decoration-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 3)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(setq default-directory "E:/program/")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; move window (Shift + cursor)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;;plugins
;;sbcl
(setq inferior-lisp-program "D:/emacs-24.5/sbcl/1.3.1/sbcl.exe")
(add-to-list 'load-path "D:/emacs-24.5/slime-master")
(require 'slime)
(slime-setup)
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
(global-set-key "\C-cs" 'slime-selector)
					;evil
(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'evil)
(evil-mode 1)

;;yas
(require 'yasnippet)
(setq yas/prompt-functions
      '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on)

					;ac
(auto-complete-mode 1)
(require 'auto-complete)
(global-auto-complete-mode t)

(global-set-key [(f4)] 'speedbar-get-focus)

;;cedet
(require 'cedet)
(require 'semantic)
;; Enable EDE (Project Management) features
(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

;;;;  Helper tools.

(semantic-mode)
;; smart complitions
(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;;c++
(require 'semantic/bovine/gcc)
(require 'semantic/bovine/c)
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))

(setq cedet-sys-include-dirs (list
                              "c:/MinGW/include"
                              "c:/MinGW/lib/gcc/mingw32/4.9.3/include"
                              "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++"
			      "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++/backward"
			      "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++/mingw32"
			      "c:/MinGW/lib/gcc/mingw32/4.3.3/include-fixed"
			      "c:/MinGW/mingw32/include"
			      ))

(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))
(setq semantic-c-dependency-system-include-path "c:/MinGW/lib/gcc/mingw32/4.9.3/include")

;;ecb
;;(require 'ecb)
;;(require 'ecb-autoloads)
(setq ecb-auto-activate t;自动启动ecb
      ecb-tip-of-the-day nil;不显示每日提醒
      inhibit-startup-message t;不知道什么意思,望各位指导
      ecb-auto-compatibility-check nil;
      ecb-version-check nil;
      )
(global-set-key [f8] 'ecb-activate) ;;定义F8键为激活ecb
(global-set-key [f7] 'ecb-deactivate) ;;定义F7为停止ecb
;;;; 各窗口间切换
;;(global-set-key [M-left] 'windmove-left)
;;(global-set-key [M-right] 'windmove-right)
;;(global-set-key [M-up] 'windmove-up)
;;(global-set-key [M-down] 'windmove-down)
;;;; 使某一ecb窗口最大化
;;(define-key global-map "\C-c1" 'ecb-maximize-window-directories)
;;(define-key global-map "\C-c2" 'ecb-maximize-window-sources)
;;(define-key global-map "\C-c3" 'ecb-maximize-window-methods)
;;(define-key global-map "\C-c4" 'ecb-maximize-window-history)
;;;; 恢复原始窗口布局
;;(define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)

(require 'session)
(add-hook 'after-init-hook 'session-initialize);启动时初始化session

;;记录和恢复屏幕
(load "desktop")
(desktop-load-default)
(desktop-read)

(global-set-key [(f5)] 'gdb-many-windows);gdb-many-windows快捷键[F5]
(setq gdb-use-separate-io-buffer t) ; 不需要"IO buffer"时，则设为nil

(require 'guide-key)

;;jdee
(setq auto-mode-alist
      (append '(("\\.java\\'" . jdee-mode)) auto-mode-alist))
(jdee-run-set-args "-Dfile.encoding=UTF-8")
(push 'jdee-mode ac-modes)
					;(add-hook 'jdee-mode-hook (lambda () (push 'ac-source-semantic ac-sources)
					;									(add-hook 'before-save-hook #'indent-buffer)
					;))

;;company
(add-hook 'after-init-hook 'global-company-mode)

;;自定义
(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f3] 'indent-buffer)
(add-hook 'before-save-hook #'indent-buffer)

;;ggtags
;;(require 'setup-helm-gtags)
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(ede-cpp-root-project "opengl_test"
                      :file "E:/program/c/learnopengl/learnopengl/root.txt"
                      :include-path '(
				      ".." "../include" "../inc" "../common" "../public" "."
				      "../.." "../../include" "../../inc" "../../common" "../../public"
				      ) ;; add more include
                      ;; paths here
                      :system-include-path '("c:/MinGW/include"
					     "c:/MinGW/lib/gcc/mingw32/4.9.3/include"
					     "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++"
					     "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++/backward"
					     "c:/MinGW/lib/gcc/mingw32/4.3.3/include/c++/mingw32"
					     "c:/MinGW/lib/gcc/mingw32/4.3.3/include-fixed"
					     "c:/MinGW/mingw32/include"
					     ))


