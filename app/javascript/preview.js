document.addEventListener('DOMContentLoaded', function () {
  // 新規投稿・編集ページのフォームを取得
  const sourceForm = document.getElementById('source_form');

  // プレビュー表示スペース取得
  const previewList = document.getElementById('previews');

  // 新規投稿・編集ページのフォームがなければここで終了。
  if (!sourceForm) return null;

  // input要素取得
  const fileField = document.querySelector('input[type="file"][name="source[image]"]');

  // input要素で値の変化が起きた際に呼び出される関数
  fileField.addEventListener('change', function(e) {
    // 古いプレビューが存在する場合は削除
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    // 画像を表示するためのdiv要素を生成
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    // 表示する画像を生成
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);

    // 削除ボタンを生成
    const deleteButton = document.createElement('div');
    deleteButton.setAttribute('class', 'image-delete-button');
    deleteButton.innerText = '削除';


    // 生成したHTMLの要素をブラウザに表示させる
    previewWrapper.appendChild(previewImage);
    previewWrapper.appendChild(deleteButton);
    previewList.append(previewWrapper);

    // 削除ボタンをクリックしたらプレビュー・file_field・削除ボタンを削除し、file_fieldを再生成する
    deleteButton.addEventListener('click', () => {
      const deleteImage = document.querySelector('.preview');
      const deleteFileField = document.querySelector('input[type="file"][name="source[image]"]');
      deleteImage.remove();
      deleteFileField.remove();
      deleteButton.remove();
      const newFileField = document.createElement('input');
      newFileField.setAttribute('type', 'file');
      newFileField.setAttribute('name', 'source[image]');
      newFileField.setAttribute('class', 'btn img-btn');
      newFileField.setAttribute('id', 'source_image');
      const insertArea = document.getElementById('click-upload');
      insertArea.appendChild(newFileField);
    });
  });
});