import React, { Component, PropTypes } from 'react';
import { get } from 'lodash';

import UserStats from './UserStats';

class Profile extends Component {
  componentDidMount() {
    this.props.getProfile(this.props.params.id);
  }

  render() {
    const {
      name,
      archived,
      props_count: count,
    } = this.props.userProfile;
    return (
      <div>
        <UserStats
          userName={name}
          propsReceivedCount={get(count, 'received', 0)}
          propsGivenCount={get(count, 'given', 0)}
          archived={archived}
        />
      </div>
    );
  }
}

Profile.propTypes = {
  userProfile: PropTypes.shape({
    name: PropTypes.string,
    archived: PropTypes.bool,
    props_count: PropTypes.shape({
      received: PropTypes.number,
      given: PropTypes.number,
    }),
  }),
  params: PropTypes.shape({
    id: PropTypes.string.isRequired,
  }),
  getProfile: PropTypes.func,
};

Profile.defaultProps = {
  userProfile: {},
};

export default Profile;
