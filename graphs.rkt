#lang racket/base

;; INSTALL:
;;   raco pkg install colorblind-palette pict-abbrevs
;; DONE.

(require
  plot/no-gui
  pict-abbrevs
  racket/list
  racket/string
  (only-in colorblind-palette wong-palette*))

(define deep-loop-data
  ;; iters type overhead
  '((100   try no-split 1.14)
    (100   try split    1.17)
    (1000  try no-split 2.15)
    (1000  try split    2.16)
    (10000 try no-split 19.57)
    (10000 try split    22.46)))

(define (overhead-ticks . num*)
  (overhead-ticks* num*))

(define (overhead-ticks* num*)
  (ticks
    (exact-layout num*)
    overhead-format))

(define ((exact-layout num*) ax-min ax-max)
  (for/list ((n (in-list num*))
             #:when (<= ax-min n ax-max))
    (pre-tick n #true)))

(define (overhead-format ax-min ax-max pre-ticks)
  (for/list ((pt (in-list pre-ticks)))
    (format "~ax" (pre-tick-value pt))))

(define (text-ticks xy*)
  (ticks
    (exact-layout (map first xy*))
    (num-format xy*)))

(define (add-commas/integer str)
  (define L (string-length str))
  (string-join
    (let loop ([i L]
               [acc '()])
      (let ([i-3 (- i 3)])
        (cond
         [(<= i-3 0)
          (cons (substring str 0 i) acc)]
         [else
          (loop i-3 (cons "," (cons (substring str i-3 i) acc)))]))) ""))

(define ((num-format xy*) ax-min ax-max pre-ticks)
  (for/list ((pt (in-list pre-ticks)))
    (add-commas/integer (format "~a" (cadr (assoc (pre-tick-value pt) xy*))))))

(save-pict
  "deep-loop-bars.png"
  ;; "deep-loop-bars.pdf"
  (parameterize ([plot-x-far-ticks no-ticks]
                 [plot-font-family 'modern]
                 [plot-font-size 18]
                 #;[plot-y-far-ticks no-ticks]
                 [plot-x-ticks (text-ticks '((1/2 100) (5/2 1000) (9/2 10000)))]
                 [plot-y-ticks (overhead-ticks 1 5 10 15 20 25)])
    (plot-pict
      (for/list ((tag (in-list '(no-split split)))
                 (series-offset (in-naturals)))
        (define color (list-ref wong-palette* (+ series-offset 3)))
        (rectangles
          (for/list ((y-data (in-list deep-loop-data))
                     (col-offset (in-naturals))
                     #:when (eq? tag (third y-data)))
            (define x-pos (- col-offset (* 1/2 series-offset)))
            (vector
              (ivl x-pos (+ x-pos 0.5))
              (ivl 0 (last y-data))))
          #:alpha 0.7
          #:color color
          #:line-color color))

      #:width 400
      #:height 200
      #:y-min 0
      #:y-max 25
      #:x-min 0
      #:x-max 5.5
      #:title #f
      #:x-label #f
      #:y-label #f)))



