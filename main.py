# import pandas as pd


# df_bobot.to_pickle('df_bobot.pk')
# print(df_bobot)
from flask import Flask, render_template
from module_hitung import hitung


# == WEBSERVER == #

app = Flask(__name__)
@app.route('/')
def index():
    # return 'Web App with Python Flask!'

    df_bobot, df_bobot_kualitas, df_matriks_keputusan_awal, df_normalisasi_bobot, df_element_matrik_tertimbang, df_nilai_matrik_batas, df_elemen_matriks_jarak_alternatif, df_perangkingan_alternatif = hitung()

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