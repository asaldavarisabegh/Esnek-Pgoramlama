% Sisteme çalışma anında yeni hasta bulguları eklenebilmesi için gereklidir.
:- dynamic hasta/1.
:- dynamic ritim/2.
:- dynamic p_dalgasi/2.
:- dynamic hiz/2.
:- dynamic qrs_genisligi/2.
:- dynamic pr_suresi/2.
:- dynamic rr_araligi/2.

% teşhis kuralları

% 1. Normal Sinüs Ritmi
teshis(Hasta, 'Normal Sinüs Ritmi') :-
    hasta(Hasta),
    ritim(Hasta, duzenli),
    p_dalgasi(Hasta, qrs_onunde),
    hiz(Hasta, H), H >= 60, H =< 100,
    qrs_genisligi(Hasta, dar).

% 2. Sinüs Bradikardisi
teshis(Hasta, 'Sinüs Bradikardisi') :-
    hasta(Hasta),
    ritim(Hasta, duzenli),
    p_dalgasi(Hasta, qrs_onunde),
    hiz(Hasta, H), H < 60.

% 3. Sinüs Taşikardisi
teshis(Hasta, 'Sinüs Taşikardisi') :-
    hasta(Hasta),
    ritim(Hasta, duzenli),
    p_dalgasi(Hasta, qrs_onunde),
    hiz(Hasta, H), H > 100.

% 4. Atriyal Fibrilasyon
teshis(Hasta, 'Atriyal Fibrilasyon') :-
    hasta(Hasta),
    p_dalgasi(Hasta, yok),
    ritim(Hasta, duzensiz),
    rr_araligi(Hasta, duzensiz).

% 5. 1. Derece AV Blok
teshis(Hasta, '1. Derece AV Blok') :-
    hasta(Hasta),
    pr_suresi(Hasta, PR),
    PR > 200.

% 6. Ventriküler Taşikardi (VT)
teshis(Hasta, 'Ventriküler Taşikardi') :-
    hasta(Hasta),
    qrs_genisligi(Hasta, genis),
    ritim(Hasta, duzenli),
    hiz(Hasta, H), H >= 100, H =< 250.

% Eğer hiçbir kurala uymazsa çalışacak varsayılan durum
teshis(Hasta, 'Bilinmeyen Durum / Tanimli Degil') :-
    hasta(Hasta),
    \+ (ritim(Hasta, duzenli), p_dalgasi(Hasta, qrs_onunde), hiz(Hasta, H), H >= 60, H =< 100, qrs_genisligi(Hasta, dar)), % Normal değilse
    \+ (ritim(Hasta, duzenli), p_dalgasi(Hasta, qrs_onunde), hiz(Hasta, H2), H2 < 60),
    \+ (ritim(Hasta, duzenli), p_dalgasi(Hasta, qrs_onunde), hiz(Hasta, H3), H3 > 100),
    \+ (p_dalgasi(Hasta, yok), ritim(Hasta, duzensiz), rr_araligi(Hasta, duzensiz)),
    \+ (pr_suresi(Hasta, PR), PR > 200),
    \+ (qrs_genisligi(Hasta, genis), ritim(Hasta, duzenli), hiz(Hasta, H4), H4 >= 100, H4 =< 250).


% 1. Hasta1: Her şey normal
hasta(hasta1).
ritim(hasta1, duzenli).
p_dalgasi(hasta1, qrs_onunde).
hiz(hasta1, 75).
qrs_genisligi(hasta1, dar).
pr_suresi(hasta1, 150).

% 2. Hasta2: Taşikardi belirtileri
hasta(hasta2).
ritim(hasta2, duzenli).
p_dalgasi(hasta2, qrs_onunde).
hiz(hasta2, 130).
qrs_genisligi(hasta2, dar).

% 3. Hasta3: Atriyal Fibrilasyon
hasta(hasta3).
ritim(hasta3, duzensiz).
p_dalgasi(hasta3, yok).
rr_araligi(hasta3, duzensiz).

% 4. Hasta4: 1. Derece AV Blok
hasta(hasta4).
ritim(hasta4, duzenli).
pr_suresi(hasta4, 220). % 200'den büyük



