import React, { PropTypes } from 'react';

const Thumb = ({ id, name, avatarUrl, handleClick }) => {
  const userUrl = `/app/users/${id}`;
  const handleProfileClick = (e) => {
    e.preventDefault();
    handleClick(userUrl);
  };

  return (
    <div className="col-xs-6 col-sm-3 col-md-2">
      <a
        href={userUrl}
        className="thumbnail user-card"
        onClick={handleProfileClick}
      >
        <img src={avatarUrl} alt="avatar" />
        <div className="caption">
          {name}
        </div>
      </a>
    </div>
  );
};

Thumb.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  avatarUrl: PropTypes.string.isRequired,
  handleClick: PropTypes.func.isRequired,
};

export default Thumb;
