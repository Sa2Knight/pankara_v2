class Api::SongsController < Api::BaseController
  before_action :exists?, only: :show

  #
  # 楽曲の一覧を取得
  #
  def index
    if params[:with_artist]
      render json: songs.map { |song| JSON::Song.index_with_artist(song) }
    else
      render json: songs.map { |song| JSON::Song.raw(song) }
    end
  end

  #
  # 楽曲の詳細を取得
  #
  def show
    render json: JSON::Song.show(song, @current_user)
  end

  private

    #
    # 一覧取得対象の楽曲一覧
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

    #
    # 詳細取得対象の楽曲
    #
    def song
      @song ||= Song.find_by(id: params[:id])
    end

    #
    # 一覧取得時に並び替え可能なキー
    #
    def sortable_keys
      %w[id artist_id name url]
    end

    #
    # 詳細取得対象の楽曲が存在するか?
    # TODO: 例外処理の汎用化
    #
    def exists?
      raise404 if song.blank?
    end
end
