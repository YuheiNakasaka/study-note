#sqlのチューニングをやった

スロークエリはこんな感じ。

```sql
select a.st_id, count(*) as cnt 
from 
b_table as b 
inner join
a_table as a 
on a.u_id = b.u_id and a.pref_cd = b.pref_cd 
inner join c_table as c on c.u_id = b.u_id 
where b.p_id = '13' 
and 
a.st_id in ('2800103', '1130220', '2300101', '9930111', '1130221', '2800508', '2800106', '2800102', '2800304', '1130219', '9930903', '9930112', '2800507', '1130222', '1131320', '9930408', '1131203', '2800205', '2100201', '1131403', '2800207') 
and c.c_u_id = '0610' 
group by a.st_id;
```

EXPLAINの結果を見ると、bのテーブルでfilesortとtemporaryテーブルが使用されてる。

どうもgroup byをしているbのテーブルが原因らしい。
bのindexを確認すると、b.st_idでインデックスが効いていないみたいだ。

だから、b.st_idにインデックスを追加したらusing whereだけになった。これで最低限、テーブルからのフェッチで済む。

あとインデックスは基本的にはselectの対象とwhereの対象でインデックスが張られていればusing indexになるらしい。

a.st_idもb.p_idもインデックスが張られているのになぜかusing indexにならないのはよくわからなかったけどまあまたあの分厚い本でも読もう。