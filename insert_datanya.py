import pymysql
import pandas as pd
import numpy as np
conn = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             database='db_spk_uas_2022',
                             cursorclass=pymysql.cursors.DictCursor)
cursor = conn.cursor()
df_bobot = pd.DataFrame(
    {
        'deskripsi': ['Jumlah karyawan','Kualitas kaos','Jangka waktu pembuatan','Estimasi pembuatan dalam sehari','Jumlah mesin','Harga kaos'],
        'kriteria': ['c1','c2','c3','c4','c5','c6'],
        'bobot': [0.1, 0.25, 0.2, 0.2, 0.1, 0.15],
        'keterangan': ['PROFIT','PROFIT','COST','PROFIT','PROFIT','COST']
    }
)
df_matriks_keputusan_awal = pd.DataFrame(
    {
        'nama_konveksi': ['k1','k2','k3','k4','k5','k6','k7','k8','k9','k10'],
        'c1': [6,5,2,4,7,5,9,6,4,3],
        'c2': [4,3,5,1,3,4,3,2,5,2],
        'c3': [26,21,27,24,28,23,22,26,22,22],
        'c4': [48,24,36,36,60,24,60,48,24,24],
        'c5': [24,8,12,8,24,8,8,24,8,6],
        'c6': [55,60,55,65,65,55,65,60,50,60],  
    }
)

sql_bobot = """INSERT INTO `tbl_bobot`(`id_bobot`, `deskripsi`, `kriteria`, `bobot`, `keterangan`) VALUES (NULL,%s,%s,%s,%s)"""
sql_bobot_del = """DELETE FROM tbl_bobot"""
param_bobot = []
sql_alternatif = """INSERT INTO `tbl_alternatif`(`id_alter`, `nama`, `c1`, `c2`, `c3`, `c4`, `c5`, `c6`) VALUES (NULL,%s,%s,%s,%s,%s,%s,%s)"""
sql_alternatif_del = """DELETE FROM tbl_alternatif"""
param_alternatif = []

for i in range(len(df_bobot)):
    item = df_bobot.iloc[i]

    deskripsi = item['deskripsi']
    kriteria = item['kriteria']
    bobot = float(item['bobot'])
    keterangan = item['keterangan']
    param = [deskripsi, kriteria, bobot, keterangan]
    print(param)
    param_bobot.append(param)

for i in range(len(df_matriks_keputusan_awal)):
    item = df_matriks_keputusan_awal.iloc[i]
    nama = item['nama_konveksi']
    c1 = str(float(item['c1']))
    c2 = str(float(item['c2']))
    c3 = str(float(item['c3']))
    c4 = str(float(item['c4']))
    c5 = str(float(item['c5']))
    c6 = str(float(item['c6']))
    param = [nama, c1, c2, c3, c4, c5, c6]

    param_alternatif.append(param)


try:
    cursor.execute(sql_bobot_del, [])
    cursor.execute(sql_alternatif_del, [])

    print(sql_bobot)
    print(sql_alternatif)
    print(param_bobot)
    print(param_alternatif)

    cursor.executemany(sql_bobot, param_bobot)
    cursor.executemany(sql_alternatif, param_alternatif)

    conn.commit()
    print(param_bobot)
    print(param_alternatif)
    # tbl_bobot
    # tbl_alternatif
except Exception as ex:
    print(ex)
    conn.rollback()
