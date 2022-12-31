# import pandas as pd


# df_bobot.to_pickle('df_bobot.pk')
# print(df_bobot)

from data_cache import pandas_cache
import datetime
import pandas as pd
import numpy as np
from flask import Flask, render_template
import pymysql
conn = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             database='db_spk_uas_2022',
                             cursorclass=pymysql.cursors.DictCursor)
cursor = conn.cursor()



PROFIT = 'PROFIT'
COST = 'COST'

#@pandas_cache
def init_first():
    # df_bobot = pd.DataFrame(
    #     {
    #         'deskripsi': ['Jumlah karyawan','Kualitas kaos','Jangka waktu pembuatan','Estimasi pembuatan dalam sehari','Jumlah mesin','Harga kaos'],
    #         'kriteria': ['c1','c2','c3','c4','c5','c6'],
    #         'bobot': [0.1, 0.25, 0.2, 0.2, 0.1, 0.15],
    #         'keterangan': ['PROFIT','PROFIT','COST','PROFIT','PROFIT','COST']
    #     }
    # )
    df_bobot_kualitas = pd.DataFrame(
        {
            'kualitas_kaos': ['Pas','Jahitan miring','Tidak Simetris','Bolong','Kekecilan'],
            'rating': [5,4,3,2,1]
        }
    )
    # df_matriks_keputusan_awal = pd.DataFrame(
    #     {
    #         'nama_konveksi': ['k1','k2','k3','k4','k5','k6','k7','k8','k9','k10'],
    #         'c1': [6,5,2,4,7,5,9,6,4,3],
    #         'c2': [4,3,5,1,3,4,3,2,5,2],
    #         'c3': [26,21,27,24,28,23,22,26,22,22],
    #         'c4': [48,24,36,36,60,24,60,48,24,24],
    #         'c5': [24,8,12,8,24,8,8,24,8,6],
    #         'c6': [55,60,55,65,65,55,65,60,50,60],  
    #     }
    # )
    df_bobot = pd.read_sql('SELECT * FROM tbl_bobot', conn)
    df_matriks_keputusan_awal = pd.read_sql('SELECT * FROM tbl_alternatif', conn)

    df_bobot['bobot'] = df_bobot['bobot'].astype(np.float64)
    df_matriks_keputusan_awal['c1'] = df_matriks_keputusan_awal['c1'].astype(np.float64)
    df_matriks_keputusan_awal['c2'] = df_matriks_keputusan_awal['c2'].astype(np.float64)
    df_matriks_keputusan_awal['c3'] = df_matriks_keputusan_awal['c3'].astype(np.float64)
    df_matriks_keputusan_awal['c4'] = df_matriks_keputusan_awal['c4'].astype(np.float64)
    df_matriks_keputusan_awal['c5'] = df_matriks_keputusan_awal['c5'].astype(np.float64)
    df_matriks_keputusan_awal['c6'] = df_matriks_keputusan_awal['c6'].astype(np.float64)

    return df_bobot, df_bobot_kualitas, df_matriks_keputusan_awal


df_bobot, df_bobot_kualitas, df_matriks_keputusan_awal = init_first()


# print(df_bobot)
# print(df_bobot_kualitas)
# print(df_matriks_keputusan_awal)

# TAHAP 1
#@pandas_cache
def hitung_normalisasi_bobot():
    df_normalisasi_bobot = df_matriks_keputusan_awal.copy()
    df_normalisasi_bobot_columns = df_normalisasi_bobot.columns
    for col in df_normalisasi_bobot_columns:
        # idx = df_normalisasi_bobot.index[df_normalisasi_bobot[col] == ]
        idx_bobot = df_bobot[df_bobot['kriteria'] == col].index
        if len(idx_bobot) == 0: continue # jika tidak ditemukan indexnya criteria bobot, skip

        ket_bobot = df_bobot.loc[idx_bobot]['keterangan'][idx_bobot[0]]
        tmp_df = df_normalisasi_bobot[col].to_list() # biar gk error, hehe
        if ket_bobot == PROFIT:
            rumus_profit = lambda x, arr: ((x - min(arr)) / (max(arr) - min(arr)))
            tmp_df = [rumus_profit(x, df_matriks_keputusan_awal[col].to_list()) for x in df_matriks_keputusan_awal[col]]
            # print(tmp_df, PROFIT)
        if ket_bobot == COST:
            rumus_cost = lambda x, arr: ((x - max(arr)) / (min(arr) - max(arr)))
            tmp_df = [rumus_cost(x, df_matriks_keputusan_awal[col].to_list()) for x in df_matriks_keputusan_awal[col]]
            # print(tmp_df, COST)
        df_normalisasi_bobot[col] = tmp_df

        # print(ket_bobot.iloc[idx_bobot[0]])
        # print(idx_bobot, len(idx_bobot))
        # print(col)
        # print(df_bobot.loc[idx_bobot])
        # print(df_normalisasi_bobot[col])
        # print(idx)

        # for k, x in enumerate(df_normalisasi_bobot.itertuples()):
        #     item = df_normalisasi_bobot.iloc[k]
        #     print(item)
    return df_normalisasi_bobot

df_normalisasi_bobot = hitung_normalisasi_bobot()

# TAHAP 2
#@pandas_cache
def hitung_element_matrik_tertimbang():
    df_element_matrik_tertimbang = df_normalisasi_bobot.copy()
    df_element_matrik_tertimbang_columns = df_element_matrik_tertimbang.columns
    for col in df_element_matrik_tertimbang_columns:
        idx_bobot = df_bobot[df_bobot['kriteria'] == col].index
        if len(idx_bobot) == 0: continue # jika tidak ditemukan indexnya criteria bobot, skip

        bobot_total = df_bobot.loc[idx_bobot]['bobot'][idx_bobot[0]]
        # print(bobot_total)
        # print(col)

        tmp_df = df_element_matrik_tertimbang[col].to_list() # biar gk error, hehe

        rumus = lambda x: (x*bobot_total) + bobot_total
        tmp_df = [rumus(x) for x in df_normalisasi_bobot[col]]
        df_element_matrik_tertimbang[col] = tmp_df

        # print(ket_bobot.iloc[idx_bobot[0]])
        # print(idx_bobot, len(idx_bobot))
        # print(col)
        # print(df_bobot.loc[idx_bobot])
        # print(df_element_matrik_tertimbang[col])
        # print(idx)

        # for k, x in enumerate(df_element_matrik_tertimbang.itertuples()):
        #     item = df_element_matrik_tertimbang.iloc[k]
        #     print(item)
    # print(df_element_matrik_tertimbang)
    return df_element_matrik_tertimbang

df_element_matrik_tertimbang = hitung_element_matrik_tertimbang()

# TAHAP 3
#@pandas_cache
def hitung_nilai_matrik_batas():
    df_nilai_matrik_batas = pd.DataFrame(data=[[1 for x in df_element_matrik_tertimbang.columns.to_list()]], columns=df_element_matrik_tertimbang.columns.to_list())
    df_nilai_matrik_batas_columns = df_nilai_matrik_batas.columns
    for col in df_nilai_matrik_batas_columns:
        idx_bobot = df_bobot[df_bobot['kriteria'] == col].index
        if len(idx_bobot) == 0: continue # jika tidak ditemukan indexnya criteria bobot, skip

        prod = df_element_matrik_tertimbang[col].product(axis=0)
        m = 1/len(df_element_matrik_tertimbang[col])
        # print(df_nilai_matrik_batas[col])
        tmp_df = [prod ** m for x in df_nilai_matrik_batas[col]]
        df_nilai_matrik_batas[col] = tmp_df
        # print(prod, prod**0.1)

    # print(df_nilai_matrik_batas)
    return df_nilai_matrik_batas

df_nilai_matrik_batas = hitung_nilai_matrik_batas()

# TAHAP 4
#@pandas_cache
def hitung_elemen_matriks_jarak_alternatif():
    df_elemen_matriks_jarak_alternatif = df_element_matrik_tertimbang.copy()
    df_elemen_matriks_jarak_alternatif_columns = df_elemen_matriks_jarak_alternatif.columns
    for col in df_elemen_matriks_jarak_alternatif_columns:
        idx_bobot = df_bobot[df_bobot['kriteria'] == col].index
        if len(idx_bobot) == 0: continue # jika tidak ditemukan indexnya criteria bobot, skip

        # print(df_elemen_matriks_jarak_alternatif[col])
        # print(df_nilai_matrik_batas[col][0])
        g = df_nilai_matrik_batas[col][0]
        # print(g)

        tmp_df = df_element_matrik_tertimbang[col].to_list() # biar gk error, hehe

        tmp_df = [x - g for x in df_element_matrik_tertimbang[col]]
        df_elemen_matriks_jarak_alternatif[col] = tmp_df
    # print(df_elemen_matriks_jarak_alternatif)
    return df_elemen_matriks_jarak_alternatif

df_elemen_matriks_jarak_alternatif = hitung_elemen_matriks_jarak_alternatif()

# TAHAP 5
#@pandas_cache
def perangkingan_alternatif():
    df_rangking_alternatif = pd.DataFrame({
        'total': [],
        'rank': [],
    })
    print(df_elemen_matriks_jarak_alternatif)
    # print(df_elemen_matriks_jarak_alternatif['c1'].sum())
    # df_rangking_alternatif['total'] = df_elemen_matriks_jarak_alternatif['c1','c2','c3','c4','c5','c6'].sum()
    # df_rangking_alternatif['total'] = df_elemen_matriks_jarak_alternatif['c1', 'c2'].sum(axis=1)
    df_elemen_matriks_jarak_alternatif.drop(columns=['id_alter'], inplace=True)
    df_rangking_alternatif['total'] = df_elemen_matriks_jarak_alternatif.sum(axis=1)
    df_rangking_alternatif['rank'] = df_rangking_alternatif['total'].rank(axis=0, ascending=False)
    return df_rangking_alternatif

df_perangkingan_alternatif = perangkingan_alternatif()

print('df_bobot')
print(df_bobot)
print('-'*50)

print('df_bobot_kualitas')
print(df_bobot_kualitas)
print('-'*50)

print('df_matriks_keputusan_awal')
print(df_matriks_keputusan_awal)
print('-'*50)

print('df_normalisasi_bobot')
print(df_normalisasi_bobot)
print('-'*50)

print('df_element_matrik_tertimbang')
print(df_element_matrik_tertimbang)
print('-'*50)

print('df_nilai_matrik_batas')
print(df_nilai_matrik_batas)
print('-'*50)

print('df_elemen_matriks_jarak_alternatif')
print(df_elemen_matriks_jarak_alternatif)
print('-'*50)

print('df_perangkingan_alternatif')
print(df_perangkingan_alternatif)
print('-'*50)


# == WEBSERVER == #

app = Flask(__name__)
@app.route('/')
def index():
    # return 'Web App with Python Flask!'
    return render_template('index.html', 
        df_bobot=df_bobot,
        df_bobot_kualitas=df_bobot_kualitas,
        df_matriks_keputusan_awal=df_matriks_keputusan_awal,
        df_normalisasi_bobot=df_normalisasi_bobot,
        df_element_matrik_tertimbang=df_element_matrik_tertimbang,
        df_nilai_matrik_batas=df_nilai_matrik_batas,
        df_elemen_matriks_jarak_alternatif=df_elemen_matriks_jarak_alternatif,
        df_perangkingan_alternatif=df_perangkingan_alternatif
    )

app.run(host='0.0.0.0', port=81, debug=True)