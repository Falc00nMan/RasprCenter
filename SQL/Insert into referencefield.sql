select * from sysobjects where xtype = 'u'
sprWhouse	469576711
sprThermoType	1141579105


select * from syscolumns where id = 469576711

insert into sprreferencefield(ReferenceID, reffieldname)
select r.ReferenceID, sc.name
from sprReference r
inner join sysobjects s on s.name = r.ReferenceTableName
inner join syscolumns sc on sc.id = s.id
order by r.referenceid, sc.colorder

