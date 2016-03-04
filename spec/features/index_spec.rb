feature 'get /game' do
  background do
    using_session :viewer1 do
      visit '/game'
    end

    using_session :viewer2 do
      visit '/game'
    end
  end

  context 'viewer1が送信する' do
    background do
      using_session :viewer1 do
        fill_in 'name', with: 'hoge'
        click_button 'submit'
      end
    end

    scenario 'viewer1のリストに追加される', js: true do
      using_session :viewer1 do
        within('ul#name_list') do
          expect(page).to have_content 'hoge'
        end
      end
    end

    scenario 'viewer2のリストにも追加される', js: true do
      using_session :viewer2 do
        within('ul#name_list') do
          expect(page).to have_content 'hoge'
        end
      end
    end

    context 'viewer2がページを更新する' do
      background do
        using_session :viewer2 do
          visit '/game'
        end
      end

      scenario 'viewer2のリストに結果が残っている', js: true do
        using_session :viewer2 do
          within('ul#name_list') do
            expect(page).to have_content 'hoge'
          end
        end
      end
    end
  end
end

