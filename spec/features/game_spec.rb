feature 'get /' do
  background do
    using_session :viewer1 do
      visit '/'
    end

    using_session :viewer2 do
      visit '/'
    end
  end

  scenario 'ゲーム開始ボタンは存在しない', js: true do
    using_session :viewer1 do
      expect(page).not_to have_button 'Game Start'
    end
  end

  feature 'viewer1が名前を送信する' do
    background do
      using_session :viewer1 do
        fill_in 'name', with: 'viewer1'
        click_button 'submit'
      end
    end

    scenario 'viewer1のリストに追加される', js: true do
      using_session :viewer1 do
        within('.user_list') do
          expect(page).to have_content 'viewer1'
        end
      end
    end

    scenario 'viewer2のリストにも追加される', js: true do
      using_session :viewer2 do
        within('.user_list') do
          expect(page).to have_content 'viewer1'
        end
      end
    end

    scenario 'viewer1の画面にゲーム開始ボタンが表示される', js: true do
      using_session :viewer1 do
        expect(page).to have_button 'Game Start'
      end
    end

    scenario 'viewer2の画面にはゲーム開始ボタンが表示されない', js: true do
      using_session :viewer2 do
        expect(page).not_to have_button 'Game Start'
      end
    end
  end
end

