class Api::SongsController < Api::BaseController
  #
  # 楽曲の一覧を取得
  #
  def index
    if params[:with_artist]
      render json: songs.map { |song| JSON::Song.generate_with_artist(song) }
    else
      render json: songs.map { |song| JSON::Song.generate(song) }
    end
  end

  private

    #
    # 一覧取得対象のイベント一覧
    # FIXME: Metrics/AbcSize
    #
    def songs
      @index = Song
               .artist_by(params[:artist_id])
               .name_by(params[:name])
               .order(params[:sort_key] => params[:sort_order])
               .page(params[:page])
               .per(params[:per])
               .includes(:artist)
    end

    def sortable_keys
      %w[id artist_id name url]
    end
end
