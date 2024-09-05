#!/bin/bash

echo "
███████╗██╗  ██╗██╗███████╗██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗██████╗ 
██╔════╝╚██╗██╔╝██║██╔════╝██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝██╔══██╗
█████╗   ╚███╔╝ ██║█████╗  ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗  ██████╔╝
██╔══╝   ██╔██╗ ██║██╔══╝  ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗
███████╗██╔╝ ██╗██║██║     ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗██║  ██║
╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝
> @ZeroSaturnn
"
if ! command -v exiftool &> /dev/null
then
    echo "ExifTool tidak ditemukan. Silakan instal terlebih dahulu."
    exit 1
fi

# Fungsi untuk menampilkan bantuan
show_help() {
    echo "Penggunaan: $0 -f <file gambar> -o <output file>"
    echo "   -f   Path ke file gambar yang ingin dihapus metadata EXIF-nya"
    echo "   -o   Path ke file output yang ingin disimpan"
    echo "   -h   Menampilkan bantuan"
}

# Inisialisasi variabel
input_file=""
output_file=""

# Parsing argumen
while getopts "f:o:h" opt; do
    case $opt in
        f)
            input_file=$OPTARG
            ;;
        o)
            output_file=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
done

# Periksa apakah file input telah ditentukan
if [ -z "$input_file" ]; then
    echo "Error: File input belum ditentukan."
    show_help
    exit 1
fi

# Periksa apakah file output telah ditentukan
if [ -z "$output_file" ]; then
    echo "Error: File output belum ditentukan."
    show_help
    exit 1
fi

# Periksa apakah file input ada
if [ ! -f "$input_file" ]; then
    echo "Error: File input tidak ditemukan."
    exit 1
fi

# Hapus metadata EXIF dari file gambar
exiftool -all= "$input_file" -o "$output_file"

# Informasi kepada pengguna
if [ $? -eq 0 ]; then
    echo "Metadata EXIF telah berhasil dihapus dari '$input_file' dan disimpan ke '$output_file'."
else
    echo "Terjadi kesalahan saat menghapus metadata EXIF."
fi
