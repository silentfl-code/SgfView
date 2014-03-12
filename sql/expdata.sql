-- Версия сервера: Oracle Database 10g Enterprise Edition Release 10.2.0.3.0 - Production With the Partitioning, OLAP and Data Mining options

SET SQLBLANKLINES ON;
SET DEFINE OFF;
ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/SYYYY HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF TZH:TZM';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
ALTER SESSION SET NLS_NCHAR_CONV_EXCP = FALSE;
ALTER SESSION SET TIME_ZONE = '+04:00';


INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(14, 'Shindo Hikaru', 32);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(13, 'Sai', 40);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(16, 'Honinbo Shusaku', 40);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(17, 'Otake Dosake', 39);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(27, 'Yamashita Keigo', 37);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(28, 'Takao Shinji', 37);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(30, 'Inori Yoko', 36);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(31, 'Kobayashi Izumi', 36);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(33, 'Wu Songsheng', 40);
INSERT INTO TEST.GAMERS(ID, NAME, RANK) VALUES
(34, 'Yu Ch`ang-hyeok', 37);
INSERT INTO TEST.GAMES(ID, PLAYERWHITE, PLAYERBLACK, "Size", DATA, PLACE, RESULT, RULES, TIMELIMIT, KOMI, "COMMENT", GAME) VALUES
(18, '16', '17', 19, '07/14/2013 22:02:31', 'Inno Castle', 'B+5.5', 1, 0, 0, NULL, 'B[qd],W[pp],B[cd],W[dq],B[jc],W[oc],B[qf],W[df],B[ed],W[bq],B[qn],W[nq],B[qj],W[rp],B[rn],W[lc],B[le],W[kd],B[oe],W[hd],B[jd],W[nb],B[ke],W[hb],B[kc],W[ld],B[jf],W[ie],B[je],W[ff],B[ih],W[ge],B[cf],W[kb],B[jb],W[la],B[ef],W[ee],B[eg],W[ci],B[dg],W[de],B[ch],W[qb],B[di],W[cj],B[dj],W[dd],B[dc],W[ec],B[fd],W[fc],B[dm],W[bl],B[dl],W[gq],B[do],W[cn],B[dn],W[co],B[go],W[qc],B[on],W[fp],B[fo],W[kq],B[mo],W[cc],B[cb],W[bc],B[bd],W[da],B[bb],W[db],B[ac],W[ip],B[dc],W[bh],B[bg],W[bi],B[ck],W[bk],B[cl],W[rd],B[re],W[pd],B[qe],W[rc],B[pe],W[cm],B[in],W[fg],B[fh],W[hp],B[ko],W[ep],B[eo],W[lp],B[jp],W[jq],B[kp],W[ne],B[nf],W[me],B[mf],W[od],B[ja],W[gh],B[ka],W[lb],B[fi],W[ag],B[af],W[hg],B[ah],W[ai],B[gi],W[hh],B[hi],W[cc],B[ag],W[po],B[ij],W[pn],B[pm],W[no],B[qm],W[om],B[nn],W[nm],B[mn],W[ok],B[ol],W[mm],B[pk],W[km],B[lm],W[nl],B[pl],W[ln],B[ll],W[mk],B[lo],W[jk],B[lk],W[ni],B[nj],W[oj],B[mj],W[mi],B[lj],W[ph],B[of],W[pg],B[qg],W[se],B[sf],W[mp],B[kn],W[sd],B[oi],W[if],B[ig],W[so],B[pj],W[rr],B[bc],W[qo],B[dc],W[sn],B[sm],W[oo],B[ro],W[sp],B[ho],W[ia],B[ib],W[ha],B[hc],W[gc],B[ic],W[ga],B[ca],W[cc],B[id],W[hf],B[dc],W[oh],B[pi],W[cc],B[nh],W[dp],B[gp],W[io],B[jo],W[dc],B[ce],W[mh],B[ng],W[hl],B[hm],W[sg],B[rf],W[il],B[ik],W[sl],B[rm],W[jl],B[kl],W[jm],B[jn],W[fm],B[gm],W[tt],W[tt],W[tt]');
INSERT INTO TEST.GAMES(ID, PLAYERWHITE, PLAYERBLACK, "Size", DATA, PLACE, RESULT, RULES, TIMELIMIT, KOMI, "COMMENT", GAME) VALUES
(15, '13', '14', 19, '07/13/2013 21:28:04', 'Home', 'W+100', 1, 0, 6.5, 'test', 'B[qd],W[pp],B[cd],W[dq],B[jc],W[oc],B[qf],W[df],B[ed],W[bq],B[qn],W[nq],B[qj],W[rp],B[rn],W[lc],B[le],W[kd],B[oe],W[hd],B[jd],W[nb],B[ke],W[hb],B[kc],W[ld],B[jf],W[ie],B[je],W[ff],B[ih],W[ge],B[cf],W[kb],B[jb],W[la],B[ef],W[ee],B[eg],W[ci],B[dg],W[de],B[ch],W[qb],B[di],W[cj],B[dj],W[dd],B[dc],W[ec],B[fd],W[fc],B[dm],W[bl],B[dl],W[gq],B[do],W[cn],B[dn],W[co],B[go],W[qc],B[on],W[fp],B[fo],W[kq],B[mo],W[cc],B[cb],W[bc],B[bd],W[da],B[bb],W[db],B[ac],W[ip],B[dc],W[bh],B[bg],W[bi],B[ck],W[bk],B[cl],W[rd],B[re],W[pd],B[qe],W[rc],B[pe],W[cm],B[in],W[fg],B[fh],W[hp],B[ko],W[ep],B[eo],W[lp],B[jp],W[jq],B[kp],W[ne],B[nf],W[me],B[mf],W[od],B[ja],W[gh],B[ka],W[lb],B[fi],W[ag],B[af],W[hg],B[ah],W[ai],B[gi],W[hh],B[hi],W[cc],B[ag],W[po],B[ij],W[pn],B[pm],W[no],B[qm],W[om],B[nn],W[nm],B[mn],W[ok],B[ol],W[mm],B[pk],W[km],B[lm],W[nl],B[pl],W[ln],B[ll],W[mk],B[lo],W[jk],B[lk],W[ni],B[nj],W[oj],B[mj],W[mi],B[lj],W[ph],B[of],W[pg],B[qg],W[se],B[sf],W[mp],B[kn],W[sd],B[oi],W[if],B[ig],W[so],B[pj],W[rr],B[bc],W[qo],B[dc],W[sn],B[sm],W[oo],B[ro],W[sp],B[ho],W[ia],B[ib],W[ha],B[hc],W[gc],B[ic],W[ga],B[ca],W[cc],B[id],W[hf],B[dc],W[oh],B[pi],W[cc],B[nh],W[dp],B[gp],W[io],B[jo],W[dc],B[ce],W[mh],B[ng],W[hl],B[hm],W[sg],B[rf],W[il],B[ik],W[sl],B[rm],W[jl],B[kl],W[jm],B[jn],W[fm],B[gm],W[tt],W[tt],W[tt]');
INSERT INTO TEST.GAMES(ID, PLAYERWHITE, PLAYERBLACK, "Size", DATA, PLACE, RESULT, RULES, TIMELIMIT, KOMI, "COMMENT", GAME) VALUES
(29, '27', '28', 19, '07/12/2013 06:22:22', 'TV Tokyo', 'W+R', 1, NULL, 5.5, NULL, 'B[oe],W[jj],B[eo],W[dd],B[pp],W[cp],B[cf],W[ep],B[jk],W[ik],B[ij],W[il],B[kk],W[ji],B[hj],W[fo],B[hh],W[li],B[jm],W[mj],B[ml],W[gl],B[ok],W[oi],B[qe],W[ef],B[dh],W[if],B[dj],W[nc],B[md],W[nd],B[ne],W[me],B[ld],W[qc],B[oh],W[le],B[kd],W[ph],B[pi],W[pj],B[qi],W[oj],B[og],W[ke],B[id],W[lb],B[fc],W[df],B[be],W[gg],B[kb],W[jd],B[jc],W[je],B[hc],W[nq],B[kp],W[no],B[pn],W[pr],B[qq],W[kr],B[mp],W[np],B[jr],W[lr],B[jq],W[qr],B[gq],W[qj],B[rh],W[cl],B[dl],W[dm],B[cm],W[em],B[ck],W[bl],B[el],W[fl],B[bm],W[ei],B[ej],W[ci],B[bk],W[di],B[fi],W[ek],B[dk],W[fh],B[fj],W[ib],B[hb],W[db],B[ch],W[fb],B[kc],W[mb],B[pc],W[pb],B[gb],W[ec],B[fa],W[eb],B[qb],W[pd],B[rc],W[qd],B[rb],W[pe],B[pf],W[nf],B[rd],W[od],B[of],W[qf],B[re],W[nh],B[qh],W[ng],B[pg],W[ob],B[fd],W[he],B[ia],W[bg],B[ee],W[fe],B[ka],W[bh],B[cc],W[cd],B[fp],W[do],B[eq],W[en],B[dq],W[gp],B[fq],W[bj],B[gn],W[go],B[hn],W[cn],B[bn],W[bo],B[bq],W[cq],B[cr],W[dp],B[rr],W[fn],B[hg],W[qm],B[rp],W[mo],B[eh],W[cg],B[fg],W[rs],B[bd],W[cb],B[ed],W[de],B[ff],W[sr],B[jh],W[rq],B[pm],W[ql],B[nm],W[kh],B[jg],W[ie],B[bb],W[bf]');
INSERT INTO TEST.GAMES(ID, PLAYERWHITE, PLAYERBLACK, "Size", DATA, PLACE, RESULT, RULES, TIMELIMIT, KOMI, "COMMENT", GAME) VALUES
(32, '30', '31', 19, '07/11/2013 06:28:22', 'Toyama', 'B+R', 1, NULL, 5.5, NULL, 'B[pd],W[dd],B[pq],W[dp],B[qo],W[kq],B[fq],W[eq],B[fp],W[dn],B[iq],W[nq],B[ci],W[cg],B[cl],W[bn],B[fc],W[dc],B[ic],W[jo],B[io],W[in],B[ho],W[jp],B[jr],W[ei],B[dh],W[fd],B[gd],W[fe],B[eh],W[hd],B[gc],W[ge],B[fi],W[hc],B[hb],W[id],B[jc],W[ib],B[jb],W[gb],B[ia],W[fb],B[oc],W[qi],B[qg],W[ql],B[jn],W[oo],B[kn],W[pr],B[qr],W[qn],B[po],W[pn],B[or],W[ro],B[rp],W[oq],B[pp],W[nr],B[ps],W[im],B[jl],W[hk],B[gm],W[gn],B[fn],W[gl],B[fm],W[hm],B[lp],W[lo],B[ko],W[kp],B[no],W[mp],B[op],W[mn],B[nm],W[ll],B[kl],W[mm],B[kj],W[fl],B[el],W[em],B[en],W[dm],B[hi],W[ij],B[jh],W[fj],B[gi],W[ek],B[dl],W[dk],B[ck],W[dj],B[cj],W[gj],B[il],W[di],B[hl],W[ch],B[nl],W[ke],B[nj],W[qe],B[qd],W[rd],B[rc],W[lc],B[lb],W[nn],B[on],W[om],B[oo],W[hj],B[ki],W[ni],B[oi],W[oj],B[ok],W[pj],B[nh],W[mi],B[mj],W[mb],B[ld],W[kb],B[kc],W[la],B[md],W[mc],B[kd],W[ob],B[pb],W[nc],B[nd],W[oh],B[oa],W[na],B[nb],W[mo],B[kr],W[ob],B[pa],W[pg],B[ep],W[do],B[dq],W[cq],B[er],W[cr],B[nb],W[re],B[og],W[ph],B[pf],W[pe],B[oe],W[qf],B[of],W[rg],B[mh],W[ii],B[ih],W[hh],B[gg],W[hg],B[hf],W[ig],B[if],W[jg],B[kg]');
INSERT INTO TEST.GAMES(ID, PLAYERWHITE, PLAYERBLACK, "Size", DATA, PLACE, RESULT, RULES, TIMELIMIT, KOMI, "COMMENT", GAME) VALUES
(35, '33', '34', 19, '07/10/2013 06:30:00', 'Toyama', 'B+R', 1, NULL, 5.5, NULL, 'B[pd],W[dp],B[pp],W[dc],B[de],W[dh],B[gd],W[ee],B[ef],W[fe],B[dd],W[fc],B[cc],W[ec],B[ff],W[ge],B[cb],W[np],B[gf],W[he],B[qn],W[jp],B[cn],W[cl],B[cq],W[dq],B[cp],W[do],B[bn],W[em],B[mc],W[nn],B[jc],W[je],B[ig],W[le],B[lh],W[gh],B[hf],W[ii],B[ne],W[kg],B[jh],W[lg],B[kh],W[ng],B[kk],W[km],B[ik],W[hm],B[pg],W[md],B[nc],W[lc],B[lb],W[kc],B[kb],W[jd],B[ic],W[hd],B[oq],W[nq],B[nr],W[mr],B[or],W[rf],B[rd],W[pf],B[qg],W[qf],B[pi],W[nd],B[od],W[oe],B[lr],W[ni],B[pl],W[kq],B[mq],W[cf],B[df],W[cg],B[gi],W[cr],B[br],W[dr],B[bs],W[mp],B[lq],W[lp],B[gk],W[ei],B[im],W[in],B[jm],W[jn],B[fl],W[fm],B[hl],W[gm],B[cj],W[fj],B[bl],W[gj],B[kl],W[jl],B[il],W[lm],B[be],W[ih],B[jg],W[qk],B[pk],W[qj],B[pj],W[rh],B[of],W[rm],B[rg],W[rn],B[ro],W[qm],B[og],W[ri],B[sh],W[si],B[sg],W[nf],B[pe],W[ks],B[pn],W[pm],B[kr],W[jr],B[ms],W[ce],B[cd],W[bf],B[gb],W[hb],B[hc],W[gc],B[fb],W[eb],B[ib],W[bd],B[bc],W[ae],B[mh],W[nh],B[kf],W[mf],B[jf],W[ke],B[ci],W[jj],B[kj],W[on],B[ji],W[rp],B[so],W[qo],B[qp],W[po],B[rq],W[bh],B[hj],W[bk],B[ck],W[bm],B[cm],W[al],B[dl],W[hi],B[ij],W[fi],B[bj],W[aj],B[ai],W[bi],B[ak],W[sn],B[sp],W[aj],B[bl],W[ah],B[am]');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(1, 'None');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(2, '30k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(3, '29k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(4, '28k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(5, '27k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(6, '26k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(7, '25k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(85, '10d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(8, '24k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(9, '23k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(10, '22k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(11, '21k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(12, '20k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(13, '19k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(14, '18k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(15, '17k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(16, '16k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(17, '15k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(18, '14k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(19, '13k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(20, '12k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(21, '11k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(22, '10k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(23, '9k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(24, '8k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(25, '7k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(26, '6k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(27, '5k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(28, '4k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(29, '3k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(30, '2k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(31, '1k');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(32, '1d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(33, '2d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(34, '3d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(35, '4d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(36, '5d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(37, '6d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(38, '7d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(39, '8d');
INSERT INTO TEST.RANK(ID, NAME) VALUES
(40, '9d');
INSERT INTO TEST.RULES(ID, NAME) VALUES
(1, 'Japan');
INSERT INTO TEST.RULES(ID, NAME) VALUES
(2, 'Chinese');
INSERT INTO TEST.RULES(ID, NAME) VALUES
(3, 'Ing');
INSERT INTO TEST.RULES(ID, NAME) VALUES
(4, 'Old chinese');